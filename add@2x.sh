#! /bin/sh

for eachfile in $(ls -B $1)
do
 
 # j截取
 filename=${eachfile%.png}

 mv $1/${eachfile} $1/${filename}@2x.png

done
