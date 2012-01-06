#!/bin/false

DEFAULT_EDITOR=(vi)

editor()
{
    local editor=( "${DEFAULT_EDITOR[@]}" )
    if [ -n "${EDITOR[*]}" ]
    then
        editor=( "${EDITOR[@]}" )
    elif [ -n "${VISUAL[*]}" ]
    then
        editor=( "${VISUAL[@]}" )
    fi
    echo -n "${editor[@]}"  "$@"
}

macroify editor

edit()
{
    @args filename
    @editor "$filename"        
}
