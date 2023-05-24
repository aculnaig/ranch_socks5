-module(ranch_socks5_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
  {ok, _} = ranch:start_listener(tcp_socks5, ranch_tcp, #{socket_opts => [{port, 5555}]}, socks5_protocol, []),
  ranch_socks5_sup:start_link().

stop(_State) ->
  ok = ranch:stop_listener(tcp_socks5),
  ok.
