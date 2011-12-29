#!/bin/false

# Usage is a way to specify command line arguments
# using typical usage statements.

# optional    []
# group       ()
# alternation |

# sequence   = ( group | optional | subseq )+
# group      = \( sequence alternatation* \)
# optional   = \[ sequence alternatation* \]
# subseq     = ( variable | flag )+ repeat?
# variable   = word
# flag       = [a-zA-Z0-9]
# option     = ( --word | -flags+ ) variable?
# repeat     = ...

usage_tokenize ()
{
    for tok
    do
        case "$tok" in
            '[') echo 'opt_st:' ;;
            ']') echo 'opt_end:' ;;
            '(') echo 'grp_st:' ;;
            ')') echo 'grp_end:' ;;
            '|') echo 'alt:' ;; 
          '...') echo 'rep:' ;;
            -* ) echo "flag:$tok" ;;
             * ) echo "var:$tok" ;;
        esac
    done
}
