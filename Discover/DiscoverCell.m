//
// DiscoverCell.h
// XNOnline
//
// Created by xiaoniu on 2019/06/28.
// Copyright © 2019 xiaoniu88. All rights reserved.
//
#import "DiscoverCell.h"
#import "Discover.h"

@interface DiscoverCell()

@end

@implementation DiscoverCell

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

- (void)configCellWithData:(id)item {
    [super configCellWithData:item];

    Discover *data = item;


}

+ (CGFloat)cellHeight {
    return scaleY(44);
}

@end


