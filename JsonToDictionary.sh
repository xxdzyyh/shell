#!bin/sh

sed -i 's/false\s*\,/0,/' $1
sed -i 's/true\s*\,/1,/' $1
sed -i 's/\"/ \"/' $1
sed -i 's/\"\s*:\s*/\" : /' $1
sed -i 's/\s\"/ @\"/g' $1
sed -i 's/[0-9\{\[]\+\,\?/@&/' $1