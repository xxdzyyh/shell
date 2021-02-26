bServer='/Users/mac/WorkSpace/BugInsight-Server'
bWeb='/Users/mac/WorkSpace/BugInsight-web'
aServer='/Users/mac/WorkSpace/Server-BigData'
aWeb='/Users/mac/WorkSpace/DataWise-report'
bIOS='/Users/mac/WorkSpace/BugInsight-ios-sdk'
aIOS='/Users/mac/WorkSpace/datawise-ios-sdk'


filePaths=($bServer $bWeb $bIOS $aServer $aWeb $aIOS)

printBranchInfo() {
	array=$1
	for i in ${array[*]}
	do
		f=${i##*/}
		cd $i
		echo $f"         "`git branch --show-current`"\n"
	done
}

printBranchInfo "${filePaths[*]}"

