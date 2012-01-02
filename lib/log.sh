#!/bin/false

log ()
{
    @args level msg
    echo -n  "$msg"  | fmt -t 1>&2
}
