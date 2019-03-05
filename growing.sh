inject() {

	echo $1

	# sed -i "s/BINDINGGROWING/self.view/g" $1
}


checkFile() {
	for file in `ls "$1"`
	do
		path=$1/$file
	
		if [[ -d $path ]]; then
			# 目录
			checkFile $path
		else
			if [[ $file == *.m ]]; then
				#statements
				inject $path
			fi
		fi
	done
}

checkFile $SRCROOT





