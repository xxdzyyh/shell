#!/bin/bash -ilex
 #create adhoc.plist
 cat >  ~/Desktop/development.plist <<EOF
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
 <key>compileBitcode</key>
 <false/>
 <key>method</key>
 <string>development</string>
 <key>provisioningProfiles</key>
 <dict>
     <key>com.qweq.qweqweo</key>
     <string>xxx xxxxx</string>
     <key>com.xxxx.xxxxxx</key>
     <string>dev xxxxxx</string>
 </dict>
 </dict>
 </plist>
 EOF
 
 #clean
 xcodebuild clean -configuration "Release" -alltargets
 
 #dirname
 dir="/Users/xxxxx/Desktop/Live `date +%Y-%m-%d-%H-%M-%S`"
 archiverpath="${dir}/Live.xcarchive"
 
 logPath="/Users/xxxxx/Desktop/fir.log"

 cat /dev/null > $logPath

 #archive
 xcodebuild -workspace Live.xcworkspace -scheme Live -archivePath "${archiverpath}" archive
 
 #export ipa
 xcodebuild -exportArchive -archivePath "${archiverpath}"  -exportPath "${dir}"  -exportOptionsPlist /Users/xxxxx/Desktop/development.plist
 
 # #upload
 fir publish -T xxxxxxxxxxxxxxxxxxxx -L $logPath "${dir}/Live.ipa"

 if grep -q 'Published succeed' $logPath
 then 
     link=$(grep 'Published succeed' $logPath)
     app=$(grep 'Uploading app:' $logPath) 

     message='线上环境构建成功  '${app#*app: }'  '${link#*succeed: }
    #发消息到微信群
     curl --data-urlencode "message=${message}" http://xxxxxx:xxxx/sendWeixinNotify\?agentid\=xxxxxx\&auth\=xxxxxxx
 else 
     message='线上环境构建失败'
     #发消息到微信群
     curl --data-urlencode "message=${message}" http://xxxxxx:xxx/sendWeixinNotify\?agentid\=xxxxxx\&auth\=xxxxxx
 fi