originPath=$1

contains() {
	array=$1
	isContain=0
	for i in ${array[*]}
	do
		if [[ $i == $2 ]]; then
			isContain=1
		fi
	done
	return $isContain
}

whiteList=('node_modules' '_book')
whiteFileList=('book.json' 'SUMMARY.md' 'README.md')
Summary='# Summary'

# 文件夹路径 缩进
listFile() {
	SAVEIFS=$IFS
	IFS=$'\n'
	local path=$1
	local insert=$2
	local f=${path##*/}
	local fullPath=$originPath"/"$path
	if [[ -f $fullPath ]]; then
		contains "${whiteFileList[*]}" $f
		isInWhiteList=$?
		fileName=${f%.*}
		fileType=${f##*.}
		if [[ $fileType == 'md' && $isInWhiteList == 0 ]]; then
			Summary=$Summary"\n$insert"'- ['$fileName"]("$path")"
		fi
	else
		contains "${whiteList[*]}" $f
		isInWhiteList=$?
		
		if [[ $isInWhiteList == 0 ]]; then
			
			if [[ $path != '' ]]; then
				Summary=$Summary"\n$insert"'- '$f
				insert=$insert"\t"
			fi
			
			for f in  `ls $path`
			do
				if [[ $path == '' ]]; then
					listFile $f $insert
				else
					listFile $path"/$f" $insert
				fi
			done
		fi
	fi
	IFS=$SAVEIFS
}

cd $originPath
listFile '' ''

echo $Summary > $originPath"/SUMMARY.md"