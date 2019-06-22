awk -F '|' '{
    if (tolower($3)~"string") print "/* "$1"  "$5 $6" */""\n@property (nonatomic, copy) NSString *"$2";";
	else if (tolower($3)~"double") print "/* "$1"  "$5 $6" */""\n@property (nonatomic, assign) double "$2";";
	else if (tolower($3)~"date") print "/* "$1"  "$5 $6" */""\n@property (nonatomic, copy) NSString *"$2";";
	else if (tolower($3)~"integer") print "/* "$1"  "$5 $6" */""\n@property (nonatomic, assign) NSInteger "$2";";
	else if (tolower($3)~"long") print "/*"$1 "  "$5 $6" */""\n@property (nonatomic, assign) NSInteger "$2";";
	else if (tolower($3)~"boolean") print "/* "$1"  "$5 $6" */""\n@property (nonatomic, assign) BOOL "$2";";
	else if (tolower($3)~"list") print "/* "$1"  "$5 $6" */""\n@property (nonatomic, strong) NSArray *"$2";";
	else if (tolower($3)~"number") print "/* "$1"  "$5 $6" */""\n@property (nonatomic, strong) NSNumber *"$2";";
}' $1