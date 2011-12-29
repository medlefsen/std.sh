#!/usr/bin/env bash

if [ -n "$LIBSH_LOADED" ]
then
    exit 0
fi

guess_libsh_path ()
{
    local rpath="$0"
    while [ -h "$rpath" ]
    do
        rpath="$(readlink "$rpath")"
    done
    (
    if [ ! -e "$rpath" ] || ! cd "$(dirname "$rpath")/../lib" || [ ! -e ./bootstrap.sh ]
    then
        echo 1>&2 "Couldn't guess LIBSH_PATH"
        kill -2 $$
    fi
    pwd
    )
}

if [ -z "$LIBSH_PATH" ]
then
    export LIBSH_PATH="$(guess_libsh_path)"
fi

if [ "$#" -eq 0 ]
then
    echo "export LIBSH_PATH='$LIBSH_PATH' ;"
    echo 'source "$LIBSH_PATH/bootstrap.sh" ;'
    echo '# Usage'
    echo '# Put "export LIBSH_PATH=path/to/lib.sh/lib" in your .bashrc or script'
    echo '# Put "eval `lib.sh`" at the top of your script'
else
    source "$LIBSH_PATH/bootstrap.sh"
    source "$@"
fi
