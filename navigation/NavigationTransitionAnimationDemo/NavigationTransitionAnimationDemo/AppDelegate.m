//
//  AppDelegate.m
//  NavigationTransitionAnimationDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    self.window.backgroundColor = [UIColor whiteColor] ;
    MainViewController *mvc = [[MainViewController alloc]init] ;
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:mvc] ;
    self.window.rootViewController = navi ;
    [self.window makeKeyAndVisible] ;
    return YES;
}


@end
