std.sh
======

Bash scripting library

Usage
-----

Install lib.sh someplace on your system and make sure the lib.sh executable is
in your PATH.

Add
    export STDSH_PATH=/path/to/std.sh
to your .bashrc or to the top of your script.  Alternatively you edit the
lib.sh executable to point to the right place.

To use in your scripts just add

    eval `std.sh`

to the top of your script.

A handful of basic libraries will be automatically loaded including library
handling, 
