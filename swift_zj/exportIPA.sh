
 #clean
 xcodebuild clean -configuration "Release" -alltargets
 
 #dirname
 dir="/Users/sckj/Desktop/SparkVideo `date +%Y-%m-%d-%H-%M-%S`"
 archiverpath="${dir}/ZJVideo.xcarchive"

 xcodebuild -workspace SPARKVIDEO.xcworkspace -scheme ZJVideo -archivePath "${archiverpath}" archive

  #export ipa
 xcodebuild -exportArchive -archivePath "${archiverpath}"  -exportPath "${dir}"  -exportOptionsPlist /Users/sckj/Desktop/ExportOptions.plist
 
 # 打开文件夹,中间有空格，用双引号，否则路径不完整打开失败
 open "$dir"