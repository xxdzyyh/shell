originPath="/Users/$USER/WorkSpace/book"
githubIOPath="/Users/$USER/WorkSpace/xxdzyyh.github.io"


#******************* Summary 生成开始 **********************
# 排除 'node_modules' '_book' 'raw' 三个目录
# raw 用来存放资源
# 只有 md 文件会被记录到 Summary 中

echo "1. 开始生成Summary"

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

whiteList=('node_modules' '_book' 'raw')
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
		local isInWhiteList=$?
		fileName=${f%.*}
		fileType=${f##*.}
		if [[ $fileType == 'md' && $isInWhiteList == 0 ]]; then
			Summary=$Summary"\n$insert"'- ['$fileName"]("$path")"
		fi
	else
		contains "${whiteList[*]}" $f
		isInWhiteList=$?
		
		if [[ $isInWhiteList == 0 ]]; then
			echo $path
			if [[ $path != '' ]]; then
				if [[ -f $path'/README.md' ]]; then
					# 包含README.md 才认为是存放文字的文件夹
					Summary=$Summary"\n$insert"'- ['$f']('$path'/README.md)'
					insert=$insert"\t"

					for f in  `ls $path`
					do
						if [[ $path == '' ]]; then
							listFile $f $insert
						else
							listFile $path"/$f" $insert
						fi
					done
				fi
			else
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
	fi
	IFS=$SAVEIFS
}

cd $originPath
listFile '' ''

echo $Summary > $originPath"/SUMMARY.md"

#******************* Summary 生成完毕 **********************


echo "2. 开始生成 gitbook build"
gitbook build
isFailed=$?

if [[ $isFailed == 0 ]]; then
	# gitbook 执行成功
	echo "3. 开始提交代码"
	git add .
	git commit -m "update blog by shell"
	git push origin master


	cd $githubIOPath
	rm -r ./*
	cp -R $originPath"/_book/"* $githubIOPath
	git add .
	git commit -m "update blog by shell"
	git push origin master
else
	echo "gitbook build 失败，请检查 gitbook build 结果"
fi










