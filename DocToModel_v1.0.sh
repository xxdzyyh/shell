#!/bin/bash
# 后台文档转模型1.0

awk '$3 > 0 { if ($3 == "string") print "/* "$1"  "$5" */""\n@property (nonatomic, copy) NSString *"$2";";
	else if ($3 == "String") print "/* "$1"  "$5" */""\n@property (nonatomic, copy) NSString *"$2";";
	else if ($3 == "Double") print "/* "$1"  "$5" */""\n@property (nonatomic, assign) double "$2";";
	else if ($3 == "double") print "/* "$1"  "$5" */""\n@property (nonatomic, assign) double "$2";";
	else if ($3 == "Date") print "/* "$1"  "$5" */""\n@property (nonatomic, copy) NSString *"$2";";
	else if ($3 == "date") print "/* "$1"  "$5" */""\n@property (nonatomic, copy) NSString *"$2";";
	else if ($3 == "Integer") print "/* "$1"  "$5" */""\n@property (nonatomic, assign) NSInteger "$2";";
	else if ($3 == "long") print "/*"$1 "  "$5" */""\n@property (nonatomic, assign) NSInteger "$2";";
	else if ($3 == "boolean") print "/* "$1"  "$5" */""\n@property (nonatomic, assign) BOOL "$2";";
	else if ($3 == "list") print "/* "$1"  "$5" */""\n@property (nonatomic, strong) NSArray *"$2";";
	else if ($3 == "List") print "/* "$1"  "$5" */""\n@property (nonatomic, strong) NSArray *"$2";";
}' $1
