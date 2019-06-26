path=$1

awk 'BEGIN {
	getter="";
	constraints="";
	subviews="";
} {
	if ($0~/@property/) {
		propertyname=substr($5,2,length($5)-2);
		property="_"propertyname;
		
		if ($3!~/assign/) {
			getter=getter"- ("$4" *)" propertyname "{\n	if (!"property") {\n		"property" = [["$4" alloc] init];\n	}\n	return "property";\n}\n\n";
			subviews=subviews"[self addSubview:self."propertyname"];\n	";
			constraints=constraints"  [self."propertyname" mas_makeConstraints:^(MASConstraintMaker *make) {\
			\
			}];\n\n";
		} 
	}
} END {
	print getter >> "'$path'";
	print "- (void)setupSubviews {\n	"subviews"\n}"  >> "'$path'";
	print "- (void)setupContraints {\n    "constraints"\n}"  >> "'$path'";
}' $1