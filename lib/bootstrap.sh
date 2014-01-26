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

# Load essential libraries
# General approach is to have libraries assume full environment
# and use fakes and other tricks to bootstrap them

# Temporary fake functions until real ones are defined
alias @args='@macro args'

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


# Load libraries necessary for module
_libsh_load_library log
_libsh_load_library meta
_libsh_load_library error
_libsh_load_library macro
_libsh_load_library args

_libsh_load_library module

# Reload libraries to use real versions of macro, args, and use
_libsh_load_library log
_libsh_load_library meta
_libsh_load_library error
_libsh_load_library macro
_libsh_load_library args
