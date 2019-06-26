awk '{propertyname=substr($5,2,length($5)-2);
	property="_"propertyname;
	if ($4 == "UILabel") print "- (UILabel *)" propertyname "{\n	if (!"property") {\n		"property" = [[UILabel alloc] init];\n\n		"property".textColor = UIColorFromRGB(0x22222);\n		"property".font = [UIFont systemFontOfSize:12];\n	}\n	return "property";\n}\n";
	else if (match($3,assign)) print "";
	else print "- ("$4" *)" propertyname "{\n	if (!"property") {\n		"property" = [["$4" alloc] init];\n	}\n	return "property"\n}"
}' $1