#!/usr/bin/env bash

if [ -n "$STDSH_LOADED" ]
then
    exit 0
fi

guess_stdsh_path ()
{
    local rpath="$0"
    while [ -h "$rpath" ]
    do
        rpath="$(readlink "$rpath")"
    done
    (
    if [ ! -e "$rpath" ] || ! cd "$(dirname "$rpath")/../" || [ ! -e lib/bootstrap.sh ]
    then
        echo 1>&2 "Couldn't guess STDSH_PATH"
        kill -2 $$
    fi
    pwd
    )
}

if [ -z "$STDSH_PATH" ]
then
    export STDSH_PATH="$(guess_stdsh_path)"
fi

if [ "$#" -eq 0 ]
then
    echo "source '$STDSH_PATH/lib/bootstrap.sh' '$STDSH_PATH';"
    echo '# Usage'
    echo '# Put "export STDSH_PATH=path/to/std.sh" in your .bashrc or script'
    echo '# Put "eval `lib.sh`" at the top of your script'
else
    source "$STDSH_PATH/lib/bootstrap.sh"
    source "$@"
fi
