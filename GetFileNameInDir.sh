#!/bin/bash

dir=$1

for f in ```ls $dir```
do
	if [ -f $f ]
	then
		echo $f
	else
		echo $f
	fi

done