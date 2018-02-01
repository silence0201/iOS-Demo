//
//  SIBaseTableViewController.m
//  NEStDemo
//
//  Created by Silence on 2018/2/1.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "SIBaseTableViewController.h"

CGFloat const headerImgH = 210.0f;
CGFloat const barH = 44.0f;

@interface SIBaseTableViewController ()

@end

@implementation SIBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化滚动视图基本设置
    UITableViewController *tableVC = (UITableViewController *)self;
    UITableViewHeaderFooterView *headerV = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headerImgH + barH)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [headerV addGestureRecognizer:tap];
    tableVC.tableView.tableHeaderView = headerV;
    tableVC.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(headerImgH + barH, 0, 0, 0);
    tableVC.tableView.delaysContentTouches = NO;
    tableVC.tableView.canCancelContentTouches = YES;
}

- (void)tapAction:(UIGestureRecognizer *)tap {
    NSLog(@"%s",__FUNCTION__);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.parentViewController && [self.parentViewController respondsToSelector:@selector(childVc:scrollViewDidScroll:)]) {
        [self.parentViewController performSelector:@selector(childVc:scrollViewDidScroll:) withObject:self withObject:scrollView];
    }
}

- (void)setCurrentScrollContentOffsetY:(CGFloat)offsetY {
    if ([self isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableVC = (UITableViewController *)self;
        if (offsetY <= headerImgH) {
            [tableVC.tableView setContentOffset:CGPointMake(0, offsetY)];
        } else if (tableVC.tableView.contentOffset.y < offsetY && tableVC.tableView.contentOffset.y < headerImgH) {
            [tableVC.tableView setContentOffset:CGPointMake(0, headerImgH)];
        }
    }
}

@end
