#!/bin/sh

username="089033"
password="123456"
UserIDs="3144"

# 登录
res=$(curl -c cookie.txt -d "username=${username}&password=${password}&login_type=pwd&client_language=zh-cn" http://10.10.43.198/selfservice/login/)

if [[ $res=~".*ok.*" ]]; then
	echo "Login Success"
fi

ComeTime=$(date +"%Y-%m-01")
EndTime=$(date -v-1d +"%Y%m%d")

# 获取打卡时间
res=$(curl -b cookie.txt -d "page=1&rp=20&UserIDs=${UserIDs}&ComeTime=${ComeTime}&EndTime=${EndTime}" http://10.10.43.198/selfatt/grid/selfatt/CardTimes/)

# 测试
# res=$(cat daka.json)

sendEmail() {
	str="591392966@qq.com"

	osascript <<EOF

	--Variables
	set recipientName to "王雪峰"
	set theSubject to "考勤提醒"
	set theContent to "$1"

	set oldDelimiters to AppleScript's text item delimiters --记录开始的去限器
	set AppleScript's text item delimiters to " " --设置分隔符
	set str4Arr to every text item of "$str" -- 分割
	set AppleScript's text item delimiters to oldDelimiters -- 恢复原来的去限器
	get str4Arr --获取数组


	--Mail Tell Block
	tell application "Mail"
		
		--Create the message
		set theMessage to make new outgoing message with properties {subject:theSubject, content:theContent, visible:true}
		
		--Set a recipient
		tell theMessage

			repeat with re in str4Arr
				make new to recipient with properties {name:recipientName, address:re}
			end

		
			--Send the Message
			send
			
		end tell
	end tell
EOF

}

# brew install jq
array=$(echo $res | jq -r '.rows[] | .ClockInTime')
isSuccess=1

for i in $array; do

	temp=$(echo $i | awk -F ',' '{ 
		if ($1 > "09:30:00") 
			print "isOK=0";
		else  {
			if ($(NF-1) < "18:00:00") {
				print "isOK=0";
			} else {
				split($1,start,":");
				split($(NF-1),end,":");

				hour = end[1]-start[1];
				min = end[2]-start[2];

				if (min < 0) {
					hour = end[1]-start[1]-1;
					min = end[2]-start[2]+60;
				}

				if (hour*60+min < 7*60+30) {
					print "isOK=0"
				} else {
					print "isOK=1"
				}
			}
		}	
	}')

	eval $temp

	if [[ $isOK == 0 ]]; then
		echo "发送邮件"
		sendEmail "考勤异常，快去检查一下"
		isSuccess=0
		break
	else
		echo "考勤正常"
	fi

done

if [[ $isSuccess == 1 ]]; then
	sendEmail "考勤正常"
fi


