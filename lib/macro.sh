# @macro [ expr ... ] == eval "$(expr)"
use args

alias @macro='_stdsh_MACRO_COMMAND="${BASH_COMMAND#*#\'\''}" eval '\''eval "$(eval "$_stdsh_MACRO_COMMAND")" #'\'
alias @macro-print='_stdsh_MACRO_COMMAND="${BASH_COMMAND#*#\'\''}" eval '\''echo "$(eval "$_stdsh_MACRO_COMMAND")" #'\'

macro-command ()
{
   @args
   if [ -n "$_stdsh_MACRO_FUNCTION" ]
   then
       echo "${_stdsh_MACRO_COMMAND:$[ ${#_stdsh_MACRO_FUNCTION} +1 ]}"
   else
       echo "$_stdsh_MACRO_COMMAND"
   fi
}

macroify()
{
    @args funcname
    funcname="$(printf '%q' "$funcname")"
    alias "@$funcname=_stdsh_MACRO_FUNCTION=$funcname @macro $funcname"
}

macro? ()
{
    @args
    [[ -n "$_stdsh_MACRO_COMMAND" ]]
}
