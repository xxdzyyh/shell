# array.sh
length() {
	arr=$1
	arr_length=${#arr[*]}
}

log() {
	arr=$1
	echo "log_arr"$arr
	arr_length=${#arr[@]}
	echo $arr_length
	for i in ${arr[*]}; do
		echo "log_item_"$i
	done
}

arr_number=(1 "2" 3 4 5)
arr_string=("abc" "edf" "cdk")

# ${#数组名[@/*]} @ 和 * 都可以
arr_length=${#arr_number[@]}
echo $arr_length
# 特定下标的值
arr_index2=${arr_number[2]}

echo ${arr_number[@]}

# 增加操作
arr_number[13]=13

echo ${arr_number[@]}
# 删除操作
# unset arr_number[1]

echo ${arr_number[@]}

# 数组遍历
i=0
while [[ $i<$arr_length ]]; do
	echo "index_"${arr_number[i]}
	i=`expr $i + 1`
done

# 数组作为参数，必须加""
log "${arr_number[*]}"
