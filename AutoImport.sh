path="$1"
text="BFModel"

fileName=$(echo $path | awk -F "/" '{print $NF}')
className=$(echo $fileName | awk -F "." '{print $1}')
importString="#import \"$text.h\""

if [[ $fileName =~ .*\.m ]]; then
	if grep -q "@interface $className()" $1 ; then
		#如果有Extension，查到extension前面
		sed -i "/@interface $className()/i$importString" $1
	else 	
		sed -i "/@implementation $className/i$importString" $1
	fi
else
	if grep -q "NS_ASSUME_NONNULL_BEGIN" $1 ; then
		sed -i "/NS_ASSUME_NONNULL_BEGIN/i$importString" $1
	else
		sed -i "/@interface $className/i$importString" $1
	fi
fi


