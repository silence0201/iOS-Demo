//
//  SITabBarController.m
//  DynamicTabBarDemo
//
//  Created by 杨晴贺 on 07/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SITabBarController.h"
#import "SINavigationController.h"
#import "MainViewController.h"
#import "OtherViewController.h"

@interface SITabBarController ()

@end

@implementation SITabBarController

+ (void)initialize{
    [self setupTabBarItemTheme] ;
    [self setupTabBarTheme] ;
}

+ (void)setupTabBarItemTheme{
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
}

+ (void)setupTabBarTheme{
    
}


- (void)viewDidLoad {
    [super viewDidLoad] ;
    [self addAllViewControllers] ;
}

#pragma mark - 添加一个子控制器
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)seletedImageName {
    
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:seletedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:[[SINavigationController alloc] initWithRootViewController:childVc]];
}

#pragma mark - 添加所有子控制器
- (void)addAllViewControllers {
    MainViewController *homeVc = [MainViewController new];
    [self addOneChildVc:homeVc title:@"首页" imageName:@"home_normal" selectedImageName:@"home_highlight"];
    
    OtherViewController *workVc = [OtherViewController new];
    [self addOneChildVc:workVc title:@"其他" imageName:@"mycity_normal" selectedImageName:@"mycity_highlight"];
}

@end
