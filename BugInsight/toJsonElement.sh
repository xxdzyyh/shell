path=$1

sed 's/;//g' $path | awk 'BEGIN {
	res="JsonObject obj = new JsonObject();\n\n"
	getset=""
} {
	if ($3 > 0) {
		propertyname=$3;
		if ($2~/String/) {
			res=res"obj.addProperty(\""$3"\", toNotNullString(this."$3"));\n"
		} else if ($2~/Integer/) {
			res=res"obj.addProperty(\""$3"\", toNotNullInteger(this."$3"));\n"
		} else if ($2~/Long/) {
			res=res"obj.addProperty(\""$3"\", toNotNullLong(this."$3"));\n"
		} else if ($2~/Timestamp/) {
			res=res"if(this."$3" != null) {\n"
			res=res"	obj.addProperty(\""$3"\", this."$3".getTime());\n"
			res=res"}\n"
		} else {
			res=res"obj.addProperty(\""$3"\", this."$3");\n"
		}

		getset=getset"public void set"toupper(substr($3,1,1))substr($3,2)"("$2" "propertyname") {\n    this."propertyname" = "propertyname";\n}\n\n"
		getset=getset"public "$2" get"toupper(substr($3,1,1))substr($3,2)"() {\n    return "propertyname";\n}\n\n"
	}
} END {
	res=res"\nreturn obj;"
	print res;
	print getset;
	
}' 
