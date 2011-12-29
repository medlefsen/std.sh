#!/bin/false

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
