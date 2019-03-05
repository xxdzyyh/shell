# 过滤，只保留含有const的行
rm ~/Desktop/Define.h
rm ~/Desktop/call.txt
rm ~/Desktop/repeat.txt

grep const /Users/xiaoniu/Workspace/XNOnline/XNOnline/XNOnline/General/Classes/DataStatisticsManager/XNODataStatisticsTypeString.h >> ~/Desktop/Define.h

echo "Define finish"

# 找到项目中所有的调用语句
grep -R 'XNODataStatisticsManager shared' /Users/xiaoniu/Workspace/XNOnline/XNOnline/XNOnline >> ~/Desktop/call.txt

echo "call finish"

for i in `awk '{print $5}' ~/Desktop/Define.h`; do

	count=$(grep -c -w "$i" ~/Desktop/call.txt)
	
	# 一个常量应该最多只有一个地方用到，如果有多个地方用到，可能有问题，人工复查。
    if [[ ${count} > 1 ]]; then
    	echo $i  ${count} >> ~/Desktop/repeat.txt
    	echo "--------------------------------------" >> ~/Desktop/repeat.txt
    	grep "$i" ~/Desktop/call.txt | awk -F ':' '{print $1}' >> ~/Desktop/repeat.txt
    	echo "\n" >> ~/Desktop/repeat.txt
    fi     
done
