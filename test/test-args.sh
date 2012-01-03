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
    echo "Success ${argv[@]} $first $second"
}

test-named-variable()
{
    @args first rest...
    echo "Success ${argv[@]} $first ${rest[@]}"
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
    ( test-named-variable 1 ; )
    ( test-named-variable 1 2; )
    ( test-named-variable 1 2 3; )
}

main "$@"
