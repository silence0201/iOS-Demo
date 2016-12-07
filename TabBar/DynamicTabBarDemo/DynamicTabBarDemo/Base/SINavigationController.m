//
//  SINavigationController.m
//  DynamicTabBarDemo
//
//  Created by 杨晴贺 on 07/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SINavigationController.h"

@interface SINavigationController ()

@end

@implementation SINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/** 当第一次加载类的时候回被调用 */
+ (void)initialize{
    [self setupNavigationItemsTheme] ;
    [self setupNavigationBarTheme] ;
}

#pragma mark --- 设置导航Items的数据主题
+ (void)setupNavigationItemsTheme{
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance] ;
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                            NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                 forState:UIControlStateNormal] ;
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}
                                 forState:UIControlStateDisabled] ;
}

#pragma mark --- 设置导航栏主题
+ (void)setupNavigationBarTheme{
    UINavigationBar *navigationBar = [UINavigationBar appearance] ;
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}] ;
    [navigationBar setBarTintColor:[UIColor cyanColor]] ;
}

#pragma mark --- 拦截所有的push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES ;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)] ;
    }
    [super pushViewController:viewController animated:animated] ;
}

#pragma mark --- 拦截返回方法
-(void)backAction{
    [super popViewControllerAnimated:YES] ;
}

@end
