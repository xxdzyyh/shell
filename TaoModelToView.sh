grep -B 1 @property $1 | awk 'BEGIN {
	declear="";
	getter="";
	assign="";
	constraints="";
	subviews="";
} {
	propertyname=substr($5,2,length($5)-2);
	property="_"propertyname;
	

	if($0!~/@property/) {
		note=$0;
	};

	if ($4~/NSString/) {
		viewName=propertyname"Label";

		declear=declear note"\n@property (nonatomic, strong) UILabel *"viewName";\n";
		getter=getter"- (UILabel *)"viewName" {\n	if (!_"viewName") {\n		_"viewName" = [[UILabel alloc] init];\n	}\n	return _"viewName";\n}\n\n";
		subviews=subviews"[self addSubview:self."viewName"];\n";
		assign=assign"self."viewName".text =data."propertyname";\n";
		constraints=constraints note"\n[self."viewName" mas_makeConstraints:^(MASConstraintMaker *make) {\
		\
		}];\n\n";
	} else if ($4~/UI/) {
		viewName=propertyname;

		getter=getter"- ("$4" *)"viewName" {\n	if (!_"viewName") {\n		_"viewName" = [["$4" alloc] init];\n	}\n	return _"viewName";\n}\n\n";
		subviews=subviews"[self addSubview:self."viewName"];\n";
		constraints=constraints note"\n[self."viewName" mas_makeConstraints:^(MASConstraintMaker *make) {\
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


