//
//  AppDelegate.m
//  CircleSpreadDemo
//
//  Created by 杨晴贺 on 10/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "CircleSpreadViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    CircleSpreadViewController *vc = [[CircleSpreadViewController alloc]init];
    self.window.rootViewController = vc ;
    [self.window makeKeyAndVisible] ;
    
    return YES;
}


@end
