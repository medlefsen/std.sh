#!/usr/bin/env bash

if [ -z "$LIBSH_PATH" ]
then
    LIBSH_PATH="$(dirname "$0")/../lib"
fi

echo "export LIBSH_PATH='$LIBSH_PATH' ;"
echo 'source "$LIBSH_PATH/bootstrap.sh" ;'
echo '# Usage'
echo '# Put "export LIBSH_PATH=path/to/lib.sh/lib" in your .bashrc or script'
echo '# Put "eval `lib.sh`" at the top of your script'
