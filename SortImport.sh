#!bin/bash

var=$(grep "^#import" $1 | sort | uniq)

/usr/local/opt/gnu-sed/libexec/gnubin/sed '/interface/i\'"'${var}'" $1