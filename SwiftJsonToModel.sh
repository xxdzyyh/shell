awk -F '"' '{

	if ($2 > 0) {
		if (($4+0) > 0) {
			if (match($4,"\\\.")) {
				print "var "$2" : Double = 0.0";
			} else if (length($4) > 3) {
				print "var "$2" : String = \"\"";
			} else {
				print "var "$2" : Int = 0";
			}
		} else {
			print "var "$2" : String = \"\"";
		}
	}
}' $1

# $4+0 转为数字
# match($4,"\\\.") 匹配小数点，匹配成功返回正数
# length($4) 获取 $4 的长度