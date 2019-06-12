//
// BFBindPhoneCell.m
// BFMoney
//
// Created by xiaoniu on 2019/06/11.
// Copyright © 2019 xiaoniu88. All rights reserved.
//
#import "BFBindPhoneCell.h"

@interface BFBindPhoneCell()

@end

@implementation BFBindPhoneCell

#pragma mark - Initialize Methods

- (instancetype)initWithCellIdentifier:(NSString *)cellId {
	self = [super initWithCellIdentifier:cellId];
    if (self) {
        [self setupSubviews];
        [self setupConstraint];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupSubviews {

}

- (void)setupConstraint {

}

#pragma mark - Public Methods

- (void)setContentWithCellVM:(id)cellViewModel {

}

@end


