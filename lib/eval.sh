# @eval [ expr ... ] == eval "$(expr)"

if [ -n "$LIBSH_DEBUG" ]
then
    _LIBSH_EVAL_PREFIX='eval "CMD='\''$($_LIBSH_EVAL_CMD)'\''; echo \"\$CMD\"; eval \$CMD #"'
else
    _LIBSH_EVAL_PREFIX='eval "$($_LIBSH_EVAL_CMD) #" '
fi

_LIBSH_EVAL_PREFIX_LENGTH="${#_LIBSH_EVAL_PREFIX}"
alias @eval="$_LIBSH_EVAL_PREFIX"

filter_eval_command()
{
   if [ "${1:0:$_LIBSH_EVAL_PREFIX_LENGTH}" == "$_LIBSH_EVAL_PREFIX" ]
   then
     _LIBSH_EVAL_CMD="${1:$_LIBSH_EVAL_PREFIX_LENGTH}"
   fi
}

trap 'filter_eval_command "$BASH_COMMAND"' DEBUG

evalify()
{
    @eval args funcname
    alias "@$funcname=@eval $funcname"
}
