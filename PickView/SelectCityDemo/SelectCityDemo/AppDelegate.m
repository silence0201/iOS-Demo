//
//  AppDelegate.m
//  SelectCityDemo
//
//  Created by 杨晴贺 on 15/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    self.window.rootViewController = [ViewController new] ;
    [self.window makeKeyAndVisible] ;
    return YES;
}

@end
