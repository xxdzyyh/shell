//
// LoginListVC.m
// XNOnline
//
// Created by wangxuefeng on 2019/06/25.
// Copyright © 2019 xiaoniu88. All rights reserved.
//
#import "LoginListVC.h"

#import "Login.h"
#import "LoginCell.h"
#import "RequestResult.h"
#import "LoginDetailVC.h"
#import <YYModel/YYModel.h>
#import <SVProgressHUD/SVProgressHUD.h>

//typedef NS_ENUM(NSUInteger,LoginCellType) {
//    LoginCellTypeOne,
//    LoginCellCount
//};

@interface LoginListVC ()

@end

@implementation LoginListVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self sendDefaultRequest];
}

#pragma mark - Request

- (NSString *)defaultPath {
	return @"";
}

- (void)sendDefaultRequest {
    XFRequest *request = [[XFRequest alloc] initWithPath:[self defaultPath] finish:^(XFRequest *request, id result) {
        if (self.page == [self startPage]) {
            [self.refreshHeader endRefreshing];
        } else {
            [self.refreshFooter endRefreshing];
        }
		
		RequestResult *res = [RequestResult yy_modelWithJSON:result];
        
        if (res.isSuccess) {
            NSArray *array = [NSArray yy_modelArrayWithClass:[self modelClass] json:res.data];
            
            if (self.page == [self startPage]) {
                self.dataSource = [array mutableCopy];
            } else {
                [self.dataSource addObjectsFromArray:array];
            }
        } else {
        	Toast(res.msg);
        }
    }];
    
    [self.mainQueue push:request];
}

#pragma mark - <XFCellDelegate>

- (Class)modelClass {
	return [Login class];
}

- (Class)cellClass {
    return [LoginCell class];
}

//- (Class)cellClassForCellAtIndexPath:(NSIndexPath *)indexPath {
//  	return [LoginCell class];
//}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id obj = self.dataSource[indexPath.row];
//    
//    UIViewController *vc = [LoginDetailVC new];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end


