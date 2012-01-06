# @macro [ expr ... ] == eval "$(expr)"

alias @macro='_libsh_MACRO_COMMAND="${BASH_COMMAND#*#\'\''}" eval '\''eval "$(eval "$_libsh_MACRO_COMMAND")" #'\'
alias @macro-print='_libsh_MACRO_COMMAND="${BASH_COMMAND#*#\'\''}" eval '\''echo "$(eval "$_libsh_MACRO_COMMAND")" #'\'

macro-command ()
{
   if [ -n "$_libsh_MACRO_FUNCTION" ]
   then
       echo "${_libsh_MACRO_COMMAND:$[ ${#_libsh_MACRO_FUNCTION} +1 ]}"
   else
       echo "$_libsh_MACRO_COMMAND"
   fi
}

macroify()
{
    @macro args funcname
    funcname="$(printf '%q' "$funcname")"
    alias "@$funcname=_libsh_MACRO_FUNCTION=$funcname @macro $funcname"
}

macro? ()
{
    [[ -n "$_libsh_MACRO_COMMAND" ]]
}
