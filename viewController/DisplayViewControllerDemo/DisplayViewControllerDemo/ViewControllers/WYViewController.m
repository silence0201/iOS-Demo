//
//  WYViewController.m
//  DisplayViewControllerDemo
//
//  Created by 杨晴贺 on 02/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "WYViewController.h"
#import "ChildViewController.h"

@interface WYViewController ()

@end

@implementation WYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"网易新闻" ;
    
    [self setUpAllViewControllers] ;
    
    // 设置标题样式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *norColor = [UIColor lightGrayColor] ;
        *selColor = [UIColor blackColor] ;
        *titleWidth = [UIScreen mainScreen].bounds.size.width / 4 ;
    }] ;
    
    // 下滑线效果
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        *isUnderLineEqualTitleWidth = YES ;
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
