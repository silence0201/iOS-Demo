//
//  AppDelegate.m
//  MagicMoveDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "MagicMoveViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    MagicMoveViewController *vc = [[MagicMoveViewController alloc]init] ;
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:vc] ;
    self.window.rootViewController = na ;
    [self.window makeKeyAndVisible] ;
    
    return YES;
}


@end
