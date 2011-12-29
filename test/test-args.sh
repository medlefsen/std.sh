#!/usr/bin/env lib.sh

test-empty()
{
    @args
    echo "Success"
}

test-fixed()
{
    @args first second
    echo "Success ${argv[@]} $first $second"
}

test-variable()
{
    @args first second ...
    echo "Success ${argv[@]} $first $second ${rest[@]}"
}

main()
{
    ( test-empty; )
    ( test-empty 1; )
    ( test-fixed 1; )
    ( test-fixed 1 2; )
    ( test-fixed 1 2 3; )
    ( test-variable 1 ; )
    ( test-variable 1 2; )
    ( test-variable 1 2 3; )
}

main "$@"
