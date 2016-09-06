//
//  AppDelegate.m
//  SpreadDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "GrayViewController.h"
#import "SWRevealViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    
    // 左侧菜单栏
    LeftViewController *leftViewController = [[LeftViewController alloc]init] ;
    
    // 右侧菜单栏
    RightViewController *rightViewController = [[RightViewController alloc]init] ;
    
    // 首页
    GrayViewController *grayViewController = [[GrayViewController alloc]init] ;
    
    SWRevealViewController *revealViewController = [[SWRevealViewController alloc]initWithRearViewController:leftViewController frontViewController:grayViewController] ;
    revealViewController.rightViewController = rightViewController ;
    
    // 浮动左边距的宽度
    revealViewController.rearViewRevealWidth = 230 ;
    //是否让浮动层弹回原位
    //mainRevealController.bounceBackOnOverdraw = NO;
    [revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    
    self.window.rootViewController = revealViewController ;
    self.window.backgroundColor = [UIColor whiteColor] ;
    [self.window makeKeyWindow] ;
    
    return YES;
}


@end
