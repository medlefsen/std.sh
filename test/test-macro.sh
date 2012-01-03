#!/usr/bin/env bash

eval `lib.sh`
use macro

test-func()
{
    echo 'local numargs=$#'
    echo 'local funcname="$FUNCNAME"'
}
macroify test-func

main()
{
    @test-func arg1 arg2
    echo "numargs 0=$numargs"
    echo "funcname main=$funcname"
}

main 
