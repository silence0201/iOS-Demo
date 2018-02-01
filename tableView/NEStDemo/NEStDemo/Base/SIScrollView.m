//
//  SIScrollView.m
//  NEStDemo
//
//  Created by Silence on 2018/2/1.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "SIScrollView.h"

@interface SIScrollView()
@property (nonatomic,assign) CGPoint currentPoint;
@end

@implementation SIScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delaysContentTouches = NO;
        self.canCancelContentTouches = YES;
    }
    return self;
}

// 控制scroll是否可以滑动
- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)view;
        if (tableView.tableHeaderView) {
            // 当点击的区域在tableView头视图时，禁止scroll滑动
            return !CGRectContainsPoint(tableView.tableHeaderView.frame, self.currentPoint);
        }
        return YES;
    } else if ([view isMemberOfClass:[UITableViewHeaderFooterView class]] || [view isKindOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView")]) {
        return NO;
    }
    return YES;
}

- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view {
    // 记录当前触摸的位置
    CGPoint point = [[touches anyObject]locationInView:view];
    self.currentPoint = point;
    return YES;
}

@end
