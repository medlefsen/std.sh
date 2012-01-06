# @macro [ expr ... ] == eval "$(expr)"
use args

alias @macro='_libsh_MACRO_COMMAND="${BASH_COMMAND#*#\'\''}" eval '\''eval "$(eval "$_libsh_MACRO_COMMAND")" #'\'
alias @macro-print='_libsh_MACRO_COMMAND="${BASH_COMMAND#*#\'\''}" eval '\''echo "$(eval "$_libsh_MACRO_COMMAND")" #'\'

macro-command ()
{
   @args
   if [ -n "$_libsh_MACRO_FUNCTION" ]
   then
       echo "${_libsh_MACRO_COMMAND:$[ ${#_libsh_MACRO_FUNCTION} +1 ]}"
   else
       echo "$_libsh_MACRO_COMMAND"
   fi
}

macroify()
{
    @args funcname
    funcname="$(printf '%q' "$funcname")"
    alias "@$funcname=_libsh_MACRO_FUNCTION=$funcname @macro $funcname"
}

macro? ()
{
    @args
    [[ -n "$_libsh_MACRO_COMMAND" ]]
}
