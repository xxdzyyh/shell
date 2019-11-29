originPath='/Users/jmf66/WorkSpace/book'
githubIOPath="/Users/jmf66/Workspace/xxdzyyh.github.io"


cd $originPath

git add .
git commit -m "update"
git push origin master

cd $originPath
gitbook build
cd $githubIOPath
rm -r ./*
cp -R $originPath"/_book/"* $githubIOPath
git add .
git commit -m "update"
git push origin master