//
//  SINavigationController.m
//  TabbarDemo
//
//  Created by 杨晴贺 on 9/11/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SINavigationController.h"

#define MAINRGB [UIColor colorWithRed:18/255.0f green:183/255.0f blue:245/255.0f alpha:(1)]
@interface SINavigationController ()

@end

@implementation SINavigationController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏背景
    [[UINavigationBar appearance]setBarTintColor:MAINRGB] ;
    
    // 设置导航栏的字体颜色
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
    // 设置状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent ;
    
    // 导航栏
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    setBtn.frame = CGRectMake(0, 0, 10, 19) ;
    [setBtn setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(popToBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:setBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}

#pragma -mark Pop Action
- (void)popToBack{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}


@end
