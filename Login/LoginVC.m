//
// LoginVC.m
// XNOnline
//
// Created by wangxuefeng on 2019/06/25.
// Copyright © 2019 xiaoniu88. All rights reserved.
//
#import "LoginVC.h"
#import "Login.h"

@interface LoginVC()

@end

@implementation LoginVC

#pragma mark - Initialize Methods


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


