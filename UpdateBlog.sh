originPath="/Users/$USER/WorkSpace/book"
githubIOPath="/Users/$USER/Workspace/xxdzyyh.github.io"

# 更新SUMMARY.md
base=$originPath"/base"

Summary="# Summary"
Summary="$Summary\n"'* [基础](base.md)'

for f in ```ls $base```
do
	if [ -f "$base/$f" ]
	then
		fileName=${f%.*}
		Summary=$Summary'\n    * ['$fileName'](base/'$f')'
	fi
done

ios=$originPath"/iOS"

Summary="$Summary\n"'* [iOS](iOS.md)'

for f in ```ls $ios```
do
	if [ -f "$ios/$f" ]
	then

		fileName=${f%.*}
		
		Summary="$Summary\n"'     - ['$fileName'](iOS/'$f')'
	fi
done


echo $Summary > $originPath"/SUMMARY.md"


# cd $originPath

# git add .
# git commit -m "update"
# git push origin master

# cd $originPath
# gitbook build
# cd $githubIOPath
# rm -r ./*
# cp -R $originPath"/_book/"* $githubIOPath
# git add .
# git commit -m "update"
# git push origin master