#!/bin/false
use eval
use args
use log
use meta

throw ()
{
    @args
    if [ "$BASH_SUBSHELL" -eq 0 ] && is-interactive
    then
        kill -2 $$
    else
        exit 1
    fi
}

error ()
{
    @args msg
    log err "$msg"
    throw
}

warn ()
{
    @args msg
    log warn "$msg"
}

require ()
{
    @args msg cmd...
    if eval?
    then
        echo if ! "${cmd[@]}"
        echo then
        echo '  error' "'$msg'" 
        echo fi 
    else
        eval "$(as-eval require "${argv[@]}")"
    fi
}

assert ()
{
    @args cmd...
    echo "@require 'Assertion failed: ${cmd[*]}' '${cmd[@]}'"
}

evalify require
evalify assert
