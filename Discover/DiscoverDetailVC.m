//
// DiscoverDetailVC.m
// XNOnline
//
// Created by xiaoniu on 2019/06/28.
// Copyright © 2019 xiaoniu88. All rights reserved.
//
#import "DiscoverDetailVC.h"
#import "Discover.h"

@interface DiscoverDetailVC()

@property (strong, nonatomic) Discover *model;

@end

@implementation DiscoverDetailVC

#pragma mark - Initialize Methods

- (instancetype)initWithModel:(Discover *)model {
	self = [super init];
	if (self) {
		_model = model;
	}
	return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self sendDefaultRequest];
}

#pragma mark - Super Methods


#pragma mark - Private Methods

- (NSString *)defaultPath {
	return @"";
}

- (void)sendDefaultRequest {
    XFRequest *request = [[XFRequest alloc] initWithPath:[self defaultPath] finish:^(XFRequest *request, id result) {
        
//		RequestResult *res = [RequestResult yy_modelWithJSON:result];
//        
//        if (res.success) {
//			
//        } else {
//        	XFToast(res.msg);
//        }
    }];
    
    [self.mainQueue push:request];
}


#pragma mark - Property

@end


