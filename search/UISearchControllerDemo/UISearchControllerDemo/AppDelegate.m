//
//  AppDelegate.m
//  UISearchControllerDemo
//
//  Created by 杨晴贺 on 2017/6/1.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]] ;
    self.window.rootViewController = nav ;
    [self.window makeKeyAndVisible] ;
    return YES;
}



@end
