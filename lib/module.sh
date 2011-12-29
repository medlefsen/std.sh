#!/bin/false

module ()
{
    @args library
}

use ()
{
    @args library
    if [ "${#LIBSH_LIBRARIES[@]}" -eq 0 ]
    then
        declare -A LIBSH_LIBRARIES
    fi
    if [ -z "${LIBSH_LIBRARIES["$library"]}" ]
    then
        local lib_path="$LIBSH_PATH/${library}.sh"
        LIBSH_LIBRARIES["$library"]="$lib_path"
        if ! source "$lib_path"
        then
            unset LIBSH_LIBRARIES["$library"]
            error "Couldn't load library $lib_path"
        fi
    fi
}

