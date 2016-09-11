//
//  AppDelegate.m
//  TabbarDemo
//
//  Created by 杨晴贺 on 9/11/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "SINavigationController.h"
#import "SITabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    SITabBarViewController *tabBar = [[SITabBarViewController alloc]init] ;
    self.window.rootViewController = tabBar ;
    [self.window makeKeyAndVisible] ;
    
    return YES;
}


@end
