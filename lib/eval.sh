# @eval [ expr ... ] == eval "$(expr)"

if [ -n "$LIBSH_DEBUG" ]
then
    _LIBSH_EVAL_PREFIX='eval "CMD='\''$(eval "_LIBSH_IN_EVAL=1 $_LIBSH_EVAL_CMD")'\''; echo \"\$CMD\"; eval \$CMD #"'
else
    _LIBSH_EVAL_PREFIX='eval "$(eval "_LIBSH_IN_EVAL=1 $_LIBSH_EVAL_CMD") #" '
fi

_LIBSH_EVAL_PREFIX_LENGTH="${#_LIBSH_EVAL_PREFIX}"
alias @eval="$_LIBSH_EVAL_PREFIX"


_libsh_filter-eval-command()
{
   if [ "${1:0:$_LIBSH_EVAL_PREFIX_LENGTH}" == "$_LIBSH_EVAL_PREFIX" ]
   then
     _LIBSH_EVAL_CMD="${1:$_LIBSH_EVAL_PREFIX_LENGTH}"
   fi
}

trap '_libsh_filter-eval-command "$BASH_COMMAND"' DEBUG

as-eval()
{
    _LIBSH_IN_EVAL=1 "$@"
}


evalify()
{
    @eval args funcname
    alias "@$funcname=@eval $funcname"
}

eval? ()
{
    [[ -n "$_LIBSH_IN_EVAL" ]]
}
