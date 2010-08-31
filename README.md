lib.sh
======

Bash scripting library

Usage
-----

Install lib.sh someplace on your system and make sure the lib.sh executable is
in your PATH.

Add
    export LIBSH_PATH=/path/to/lib.sh/lib
to your .bashrc or to the top of your script.  Alternatively you edit the
lib.sh executable to point to the right place.

To use in your scripts just add

    eval `lib.sh`

to the top of your script.

A handful of basic libraries will be automatically loaded including library
handling, 
