-module(socks5_protocol).
-behaviour(ranch_protocol).

-export([start_link/3]).
-export([init/3]).

start_link(Ref, Transport, Opts) ->
	Pid = spawn_link(?MODULE, init, [Ref, Transport, Opts]),
	{ok, Pid}.

init(Ref, Transport, _Opts = []) ->
	{ok, Socket} = ranch:handshake(Ref),
	ok = Transport:setopts(Socket, [{packet, line}, binary]),
	loop(Socket, Transport).

loop(Socket, Transport) ->
	case Transport:recv(Socket, 0, 60000) of
		{ok, Data} ->
			case Data of
				<<Ver:8, Nmethods:8, Methods:8>> ->
					io:format("~s~s~s~n", [Ver, Nmethods, Methods]),
					Transport:send(Socket, <<"05FF">>);
				_ ->
					Transport:close(Socket)
			end;
		_ ->
			ok = Transport:close(Socket)
	end.
