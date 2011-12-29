#!/bin/false

log ()
{
    @args level msg
    echo -n  "$level: $msg"  | fmt -t 1>&2
}
