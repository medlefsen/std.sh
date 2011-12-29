#!/bin/false
use eval

# Allows simple arg parsing
args ()
{
    # @args ...
    local i=1 arg_cmp="-ne" argv=( "$@" )

    echo -n "local argv=( \"\$@\" )"
    while [ "$#" -ne 0 ]
    do
        if [ "$#" -eq 1 ] && [ "$1" == "..." ]
        then
            arg_cmp="-lt"
        else
            echo -n " \"$1=\$$i\""
            let ++i
        fi
        shift
    done
    echo ';'
    cat <<END
if [ \$# $arg_cmp $(( i - 1 )) ];
then
    echo "Usage: \$FUNCNAME ${argv[*]}";
    exit 1;
fi
END
}
evalify args
