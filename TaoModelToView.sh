grep -B 1 @property $1 | awk 'BEGIN {
	declear="";
	getter="";
	assign="";
	constraints="";
	subviews="";
} {
	propertyname=substr($5,2,length($5)-2);
	property="_"propertyname;
	viewName=propertyname"Label";

	if($0!~/@property/) {
		note=$0;
	};

	if ($4~/NSString/) {
		declear=declear note"\n@property (nonatomic, strong) UILabel *"viewName";\n";
		getter=getter"- (UILabel *)"viewName" {\n	if (!_"viewName") {\n		_"viewName" = [[UILabel alloc] init];\n	}\n	return _"viewName";\n}\n\n";
		subviews=subviews"[self addSubview:self."propertyname"Label];\n";
		assign=assign"self."viewName".text =data."propertyname";\n";
		constraints=constraints note"\n[self."propertyname"Label mas_makeConstraints:^(MASConstraintMaker *make) {\
		\
		}];\n\n";
	} 

} END {
	print declear;
	print "- (void)setupSubviews {\n    "subviews"\n}";
	print "- (void)setupContraints {\n    "constraints"\n}";
	print assign;
	print getter;
}' 


