//
//  AppDelegate.m
//  ModelTransitionDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    
    ViewController *vc = [[ViewController alloc]init] ;
    self.window.rootViewController = vc ;
    self.window.backgroundColor = [UIColor whiteColor] ;
    [self.window makeKeyAndVisible] ;
    
    return YES;
}


@end
