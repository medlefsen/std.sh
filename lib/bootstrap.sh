#!/bin/false

declare -A LIBSH_LIBRARIES

_libsh_is_int ()
{
    case "$_" in
        *i*) return 0 ;;
          *) return 1 ;;
     esac
}

_libsh_error ()
{
    echo 1>&2 "$@"
    if [ "$BASH_SUBSHELL" -eq 0 ] && _libsh_is_int
    then
        kill -2 $$
    else
        exit 1
    fi
}

# Stripped down version of "use" for required libs
_libsh_load_library ()
{
    local library="$1" libpath="$LIBSH_PATH/${1}.sh"
    LIBSH_LIBRARIES["$library"]="$libpath"
    if ! source "$libpath"
    then
        _libsh_error "Couldn't load library $libpath"
    fi
}

_libsh_load_library use
_libsh_load_library args
_libsh_load_library log
_libsh_load_library error
