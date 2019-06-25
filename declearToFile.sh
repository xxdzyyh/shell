# grep @property $1 | awk -f declearToFileAwk.txt
eval `grep @property $1 | awk -f declearToFileAwk.txt`

echo $getterString >> 33.txt
echo ---------------
echo $constraintsString >> 33.txt
echo ---------------
echo $subviewsString >> 33.txt
echo ---------------