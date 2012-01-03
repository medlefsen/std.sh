#!/bin/false

set -o functrace
set -o errtrace
shopt -s expand_aliases
shopt -s extdebug

export LIBSH_LOADED=1
if [ -z "$LIBSH_PATH" ]
then
    export LIBSH_PATH="$1"
fi
declare -A LIBSH_LIBRARIES


# Temporary mock functions until real ones are defined
alias @args=:

use ()
{
    :
}

error ()
{
    echo "$@"
    exit 1
}

macroify ()
{
    :
}

# Stripped down version of "use" for required libs
_libsh_load_library ()
{
    local library="$1" libpath="$LIBSH_PATH/${1}.sh"
    LIBSH_LIBRARIES["$library"]="$libpath"
    if ! source "$libpath"
    then
        error "Couldn't load library $libpath"
    fi

}


_libsh_load_library log
_libsh_load_library error
_libsh_load_library macro
_libsh_load_library args
_libsh_load_library module

# Reload log and error to use real versions of eval, args, and use
_libsh_load_library log
_libsh_load_library error

