#!/bin/false
use macro
use args
use log
use meta

throw ()
{
    @args
    if [ "$BASH_SUBSHELL" -eq 0 ] && interactive?
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
    if macro?
    then
        echo if ! "${cmd[@]}"
        echo then
        echo '  error' "'$msg'" 
        echo fi 
    else
        eval "$(as-macro require "${argv[@]}")"
    fi
}

assert ()
{
    @args cmd...
    echo "@require 'Assertion failed: ${cmd[*]}' '${cmd[@]}'"
}

macroify require
macroify assert
