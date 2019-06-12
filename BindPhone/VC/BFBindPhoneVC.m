//
// BFBindPhoneVC.m
// BFMoney
//
// Created by xiaoniu on 2019/06/11.
// Copyright © 2019 xiaoniu88. All rights reserved.
//
#import "BFBindPhoneVC.h"
#import "BFBindPhoneVM.h"

@interface BFBindPhoneVC()

@property (nonatomic, strong) BFBindPhoneVM *viewModel;

@end

@implementation BFBindPhoneVC

#pragma mark - Initialize Methods

- (instancetype)initWithViewModel:(BFBindPhoneVM *)viewModel {
	self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubviews];
    [self setupConstraint];
    [self setupEvent];
    [self showBackgroundLoadingView];
    [self sendRequest];
}

#pragma mark - Super Methods

- (void)requestHandlerWishIsRefresh:(BOOL)isRefresh {
    [self sendRequest];
}

#pragma mark - Private Methods

- (void)sendRequest {

}

- (void)setupSubviews {

}

- (void)setupConstraint {
	
}

- (void)setupEvent {

}


#pragma mark - Property

@end


