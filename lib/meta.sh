#!/bin/false
use args

func-exists ()
{
    @args func_name
    declare -F "$func_name" &>/dev/null
}

# Prints out line\tfile from where the function was sourced
# returns 1 if function doesn't exist
func-origin ()
{
    @args func_name
    declare -F "$func_name" | { 
        if read func line file
        then
            echo "$line$(echo -e '\t')$file"
        fi
    }
}

func-origin-file ()
{
    @args $func_name
    func-origin "$func_name" | cut -f 2-
}

func-print ()
{
    @args func_name
    declare -f "$func_name"
}

func-list ()
{
    @args 
    declare -F | sed 's/^declare -f //' | sort
}

func-print-body ()
{
    @args func_name
    func-print "$func_name" | tail -n +3 | head -n -1
}

func-copy ()
{
    @args old_name new_name
    eval "
function $new_name
{
    $(func-print-body "$old_name")
}"
}

func-rename()
{
    @args old_name new_name
    func-copy "$old_name" "$new_name"
    unset "$old_name"
}

interactive? ()
{
    @args
    case "$-" in
        *i*) return 0 ;;
          *) return 1 ;;
     esac
}

