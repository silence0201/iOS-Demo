//
//  TXViewController.m
//  DisplayViewControllerDemo
//
//  Created by 杨晴贺 on 02/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TXViewController.h"
#import "ChildViewController.h"

@interface TXViewController ()

@end

@implementation TXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"腾讯视频" ;
    
    CGFloat y = self.navigationController?64:0 ;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width ;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height ;
    CGFloat tabbarH = self.tabBarController?49:0 ;
    
    // 添加所有子控制器
    [self setUpAllViewControllers] ;
    
    // 设置整体内容的尺寸
    [self setUpContentViewFrame:^(UIView *contentView) {
        CGFloat contentX = 0 ;
        CGFloat contentY = y ;
        CGFloat contentH = screenH - contentY - tabbarH ;
        CGFloat contextW = screenW ;
        contentView.frame = CGRectMake(contentX, contentY, contextW, contentH) ;
    }] ;
    
    // 标题渐变
    // 默认是指为RGB样式
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        *norColor = [UIColor blackColor] ;
        *selColor = [UIColor redColor] ;
    }] ;
    
    // 设置遮盖
    [self setUpCoverEffect:^(UIColor *__autoreleasing *coverColor, CGFloat *coverCornerRadius) {
        // 设置蒙版颜色
        *coverColor = [UIColor colorWithWhite:0.7 alpha:0.4] ;
        // 设置蒙版圆角的半径
        *coverCornerRadius = 14 ;
    }] ;
}

// 添加所有控制器
- (void)setUpAllViewControllers{
    for(int i = 1 ; i<=8;i++){
        ChildViewController *vc = [[ChildViewController alloc]init] ;
        vc.title = [NSString stringWithFormat:@"第%d个",i] ;
        vc.imageName = [NSString stringWithFormat:@"%d",i] ;
        [self addChildViewController:vc] ;
    }
}

@end
