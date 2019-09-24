originPath='/Users/xiaoniu/Workspace/book'
githubIOPath="/Users/xiaoniu/Workspace/xxdzyyh.github.io"

cd $originPath

gitbook build
cp -R $originPath"/_book/"* $githubIOPath
cd $githubIOPath
git add .
git commit -m "update"
git push origin master