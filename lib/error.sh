#!/bin/false

throw ()
{
    eval `@args`
    if [ "$BASH_SUBSHELL" -eq 0 ] && is-interactive
    then
        kill -2 $$
    else
        exit 1
    fi
}

error ()
{
    eval `@args msg`
    log err "$msg"
    throw
}

warn ()
{
    eval `@args msg`
    log warn "$msg"
}
