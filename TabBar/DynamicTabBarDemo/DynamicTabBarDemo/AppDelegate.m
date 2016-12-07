//
//  AppDelegate.m
//  DynamicTabBarDemo
//
//  Created by 杨晴贺 on 07/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "SITabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    self.window.rootViewController = [[SITabBarController alloc]init] ;
    [self.window makeKeyAndVisible] ;
    return YES;
}



@end
