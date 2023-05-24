PROJECT = ranch_socks5
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0

# Whitespace to be used when creating files from templates.
SP = 2

BUILD_DEPS += relx

DEPS = ranch
dep_ranch_commit = 2.1.0

include erlang.mk
