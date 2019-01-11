#!bin/sh
# sh template.sh model fileType tableType
#
# fileType
# 	vc 一般的控制器，继承自XFViewController
#	model model
#   view view
#   cell model对应的Cell
#   table table类型的控制器，继承自XFRefreshTableViewController
#
# tableType
#	refresh 下拉刷新，没有加载更多
#   refresh & load  more 下拉刷新上拉加载更多
#   simple 没有下拉刷新和加载更多
#
#

authorInfoFunc() {
	mdate=`date +%Y/%m/%d`
	year=${mdate%%/*}
	info="//\n//	$1\n//  XNOnline\n//\n//  Created by ${USER} on ${mdate}.\n//  Copyright © ${year} xiaoniu88. All rights reserved.\n//\n\n

"
	echo $info
}

createModelFiles() {
entity=$1
authorInfo=`authorInfoFunc ${entity}.h`

# 创建model.h
echo "${authorInfo}
#import <Foundation/Foundation.h>

@interface $entity : NSObject

@end

" >> $entity".h"

# 创建Model.m
authorInfo=`authorInfoFunc ${entity}.m`

echo "${authorInfo}
#import \"${entity}.h\"
//#import <YYModel/YYModel.h>

@implementation ${entity}

//+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
//	  return @{};
//}


@end

" >> ${entity}.m
}

createVCFiles() {
	# 创建.h
	viewController=$1VC
	authorInfo=`authorInfoFunc ${viewController}.h`

	echo "${authorInfo}
#import <XFFoundation/XFFoundation.h>

@interface $viewController : XFViewController


@end

" >> $viewController.h

	authorInfo=`authorInfoFunc ${viewController}.m`
	# 创建.m
	echo "${authorInfo}
#import \"$viewController.h\"

@interface ${viewController}()


@end

@implementation ${viewController}

#pragma mark - Initialize Methods


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self sendDefaultRequest];
}

#pragma mark - Super Methods


#pragma mark - Private Methods

- (NSString *)defaultPath {
	return @\"\";
}

- (void)sendDefaultRequest {
    XFRequest *request = [[XFRequest alloc] initWithPath:[self defaultPath] finish:^(XFRequest *request, id result) {
        
//		RequestResult *res = [RequestResult yy_modelWithJSON:result];
//        
//        if (res.code == 200) {
//			
//        } else {
//        	Toast(res.msg);
//        }
    }];
    
    [self.mainQueue push:request];
}


#pragma mark - Property

@end

" >> ${viewController}.m
}

createCellXib() {
	file=$1

cat >> ${file}.xib <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="13142" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12042"/>
        <capability name="Safe area layout guides" minToolsVersion="9.0"/>
        <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner"/>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
        <tableViewCell contentMode="scaleToFill" selectionStyle="default" indentationWidth="10" id="KGk-i7-Jjw" customClass="$1">
            <rect key="frame" x="0.0" y="0.0" width="320" height="44"/>
            <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
            <tableViewCellContentView key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" tableViewCell="KGk-i7-Jjw" id="H2p-sc-9uM">
                <rect key="frame" x="0.0" y="0.0" width="320" height="43"/>
                <autoresizingMask key="autoresizingMask"/>
            </tableViewCellContentView>
            <viewLayoutGuide key="safeArea" id="aW0-zy-SZf"/>
        </tableViewCell>
    </objects>
</document>

EOF

}

createCellFiles() {

	cell=$1Cell
	authorInfo=`authorInfoFunc ${cell}.h`

	echo "${authorInfo}
#import <XFFoundation/XFFoundation.h>

@interface $cell : XFTableViewCell


@end

" >> ${cell}.h

	authorInfo=`authorInfoFunc ${cell}.h`
	
	echo "${authorInfo}
#import \"${cell}.h\"
#import \"$1.h\"

@interface ${cell}()

@end

@implementation ${cell}

#pragma mark - Initialize Methods

#pragma mark - Public Methods

- (void)configCellWithData:(id)item {
    [super configCellWithData:item];

    $1 *data = item;


}

@end

" >> ${cell}.m

createCellXib $cell
}

createTable() {
echo "createTable"
echo $1
echo $2

	list=$1ListVC
	authorInfo=`authorInfoFunc ${list}.h`

	echo "${authorInfo}
#import <XFFoundation/XFFoundation.h>

@interface $list : XFRefreshTableViewController

@end
" >> ${list}.h

# tableType
#	refresh 下拉刷新，没有加载更多
#   refresh & load  more 下拉刷新上拉加载更多
#   simple 没有下拉刷新和加载更多

refresh=""

if [[ $2 == "simple" ]]; then
	refresh="
	self.canUpdateData = NO;
	self.canAppendData = NO;
"	
elif [[ $2 == 'refresh' ]]; then
	refresh="self.canAppendData = NO;"
else
	refresh=""
fi

	authorInfo=`authorInfoFunc ${list}.m`
	echo "${authorInfo}
#import \"${list}.h\"

#import \"$1.h\"
#import \"RequestResult.h\"
#import <YYModel/YYModel.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface ${list} ()


@end

@implementation ${list}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    ${refresh}
    [self sendDefaultRequest];
}

- (NSString *)defaultPath {
	return @\"\";
}

- (void)sendDefaultRequest {
	[SVProgressHUD show];
    XFRequest *request = [[XFRequest alloc] initWithPath:[self defaultPath] finish:^(XFRequest *request, id result) {
        
        [self.refreshHeader endRefreshing];
		
		RequestResult *res = [RequestResult yy_modelWithJSON:result];
        
        if (res.code == 200) {
			self.dataSource = [[NSArray yy_modelArrayWithClass:[BuyFollowsModel class] json:res.data] mutableCopy];
        }
    }];
    
    [self.mainQueue push:request];
}

#pragma mark - <XFCellDelegate>

- (Class)cellClass {
    return [$1Cell class];
}

- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath {
	return [$1Cell class];
}

" >> ${list}.m

}


if [[ -n $1 ]]; then
echo $1
#创建一个目录

mkdir $1
cd $1

	if [[ -n $2 ]]; then
	
		if [[ $2 = "vc" ]]; then
			createVCFiles $1
		elif [[ $2 = "cell" ]]; then
			createCellFiles $1
		elif [[ $2 = "model" ]]; then
			createModelFiles $1
		elif [[ $2 = "table" ]]; then
			createTable $1 $3
		fi

	else	
		createModelFiles $1
		createVCFiles $1
		createCellFiles $1
		createTable $1 $3
	fi

path=`pwd`

osascript <<EOF
set a to  POSIX file "$path"
tell application "Finder"
	open folder a
end tell
EOF

else

	echo "please input model name"

fi





