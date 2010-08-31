#!/bin/false

print-func ()
{
    eval `@args func_name`
    set | sed -n '/^'"$1"' ()/,/^}/ p'
}

print-func-body ()
{
    eval `@args func_name`
    print-func "$func_name" | tail -n +3 | head -n -1
}

func-copy ()
{
    eval `@args old_name new_name`
    eval "
function $new_name
{
    $(print-func-body "$old_name")
}"
}

is-interactive ()
{
    eval `@args`
    case "$_" in
        *i*) return 0 ;;
          *) return 1 ;;
     esac
}
