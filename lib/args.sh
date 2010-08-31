#!/bin/false

# Allows simple arg parsing
@args ()
{
    # @args ...
    local i=1 arg_cmp="-ne" argv=( "$@" )

    echo -n "local "
    while [ "$#" -ne 0 ]
    do
        if [ "$#" -eq 1 ] && [ "$1" == "..." ]
        then
            arg_cmp="-ge"
        else
            echo -n "\"$1=\$$i\" "
        fi
        let ++i
        shift
    done
    echo ';'
    cat <<END
if [ \$# $arg_cmp ${#argv[@]} ];
then
    echo "Usage: \$FUNCNAME ${argv[*]}";
    exit 1;
fi
END

}
