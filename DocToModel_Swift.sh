#!/bin/bash
# 后台文档转模型1.0

awk '{
	print "/// "$2
	if ($3 == "string") print "var "$1" : String = \"\""
	else if ($3 == "integer(int32)") print "var "$1" : Int = 0"
}' $1
