//
//  AppDelegate.m
//  DrawerDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

#define ScreenHight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    
    UINavigationController *centerNav = [[UINavigationController alloc]initWithRootViewController:[MainViewController new]] ;
    UINavigationController *leftNav = [[UINavigationController alloc]initWithRootViewController:[LeftViewController new]] ;
    RightViewController *rightVc = [[RightViewController alloc]init] ;
    
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:centerNav leftDrawerViewController:leftNav rightDrawerViewController:rightVc] ;
    
    [self.drawerController setShowsShadow:YES] ;   // 是否显示阴影效果
    self.drawerController.maximumLeftDrawerWidth = ScreenWidth / 2 ;  // 左边拉开的最大宽度
    self.drawerController.maximumRightDrawerWidth = ScreenWidth / 2 ; // 右边拉开的最大宽度
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window.rootViewController = self.drawerController ;
    [self.window makeKeyAndVisible] ;
    
    return YES;
}


@end
