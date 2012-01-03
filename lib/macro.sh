# @macro [ expr ... ] == eval "$(expr)"

if [ -n "$LIBSH_DEBUG" ]
then
    _LIBSH_MACRO_PREFIX='eval "CMD='\''$(eval "_LIBSH_IN_MACRO=1 $_LIBSH_MACRO_CMD")'\''; echo \"\$CMD\"; eval \$CMD #"'
else
    _LIBSH_MACRO_PREFIX='eval "$(eval "_LIBSH_IN_MACRO=1 $_LIBSH_MACRO_CMD") #" '
fi

_LIBSH_MACRO_PREFIX_LENGTH="${#_LIBSH_MACRO_PREFIX}"
alias @macro="$_LIBSH_MACRO_PREFIX"


_libsh_filter-macro-command()
{
   if [ "${1:0:$_LIBSH_MACRO_PREFIX_LENGTH}" == "$_LIBSH_MACRO_PREFIX" ]
   then
     _LIBSH_MACRO_CMD="${1:$_LIBSH_MACRO_PREFIX_LENGTH}"
   fi
}

trap '_libsh_filter-macro-command "$BASH_COMMAND"' DEBUG

as-macro()
{
    _LIBSH_IN_MACRO=1 "$@"
}


macroify()
{
    @macro args funcname
    alias "@$funcname=@macro $funcname"
}

macro? ()
{
    [[ -n "$_LIBSH_IN_MACRO" ]]
}
