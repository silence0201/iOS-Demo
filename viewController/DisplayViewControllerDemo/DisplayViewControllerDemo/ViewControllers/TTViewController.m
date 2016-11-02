//
//  TTViewController.m
//  DisplayViewControllerDemo
//
//  Created by 杨晴贺 on 02/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TTViewController.h"
#import "ChildViewController.h"

@interface TTViewController ()

@end

@implementation TTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"今日头条" ;
    
    [self setUpAllViewControllers] ;
    
    // 设置题目渐变,标题填充模式
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        // 标题填充模式
        *titleColorGradientStyle = YZTitleColorGradientStyleFill ;
    }] ;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    self.selectIndex = 2 ;  // 设置选择第几个
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
