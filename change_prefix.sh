
echo 'sh file.sh -o 旧的前缀 -n 新的前缀 需要替换的目录'

while getopts "o:n:" opt; do
  case $opt in
    o)
      oldPrefix=$OPTARG 
      ;;
    n)
      newPrefix=$OPTARG 
      ;;
    \?)
      echo "Invalid option: -$OPTARG" 
      ;;
  esac
done

src=${@: -1}

echo $oldPrefix
echo $newPrefix
echo $src

for file in `find $src -name "${oldPrefix}*"`; do
	
	# 文件名，包含后缀
	fileName=${file##*/}
	
	if [[ ! -d $file ]]; then

		# 文件所在目录
		dir=${file%/*}
		# 新的文件名，包含后缀
		nFilePath=${newPrefix}${fileName#${oldPrefix}}
		# 新文件的完整地址
		nPath=${dir}/${nFilePath}

		# 原文件名，不含后缀
		oFileName=${fileName%.*}

		# 新文件名，不含后缀
		nFileName=${newPrefix}${oFileName#${oldPrefix}}

		# 文本替换
		LC_ALL=C sed -i "" "s/$oFileName/$nFileName/g" `grep $oFileName -rl $src`

		# 重命名文件
		mv -v $file $nPath
	fi
done


