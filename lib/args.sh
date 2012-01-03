#!/bin/false
use eval
use error

# Allows simple arg parsing
args ()
{
    # @args ...
    local i=1 arg_cmp="-ne" argv=( "$@" )

    echo -n "local argv=( \"\$@\" )"
    while [ "$#" -ne 0 ]
    do
        if [ "$#" -eq 1 ] && [ "${1: -3}" == "..." ]
        then
            arg_cmp="-lt"
            echo -n " ${1%...}=( \"\${@: $i }\" )"
        else
            echo -n " $1=\"\$$i\""
            let ++i
        fi
        shift
    done
    echo ';'
    cat <<END
if [ \$# $arg_cmp $(( i - 1 )) ];
then
    error "Usage: \$FUNCNAME ${argv[*]}";
fi
END
}
evalify args
