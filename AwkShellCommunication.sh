path=$1

var=$(awk 'BEGIN {
	localVar="哈哈";
	print "outvar="'localVar'"";
}' $1)

eval $var
echo $outvar