//
// BFBindPhoneView.m
// BFMoney
//
// Created by xiaoniu on 2019/06/11.
// Copyright © 2019 xiaoniu88. All rights reserved.
//
#import "BFBindPhoneView.h"
#import "BFBindPhoneVM.h"

@interface BFBindPhoneView()

@property (nonatomic, strong) BFBindPhoneVM *viewModel;

@end

@implementation BFBindPhoneView

#pragma mark - Initialize Methods

- (instancetype)initWithVM:(BFBindPhoneVM *)viewModel {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _viewModel = viewModel;
        
        [self setupSubviews];
        [self setupConstraint];
        [self bind];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        [self setupConstraint];
        [self bind];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupSubviews {

}

- (void)setupConstraint {

}

- (void)bind { 

}

#pragma mark - Public Methods


#pragma mark - Getter


@end


