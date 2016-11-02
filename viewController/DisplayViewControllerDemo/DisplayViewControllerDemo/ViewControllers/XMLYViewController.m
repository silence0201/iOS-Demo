//
//  XMLYViewController.m
//  DisplayViewControllerDemo
//
//  Created by 杨晴贺 on 02/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "XMLYViewController.h"
#import "ChildViewController.h"

@interface XMLYViewController ()

@end

@implementation XMLYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"喜马拉雅" ;
    
    [self setUpAllViewControllers] ;
    
    // 设置下标
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        // 标题填充模式
        *underLineColor = [UIColor blueColor] ;
    }] ;
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = YES;
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
