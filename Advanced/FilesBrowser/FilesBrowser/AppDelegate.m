//
//  AppDelegate.m
//  FilesBrowser
//
//  Created by 杨晴贺 on 12/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    RootViewController *rootVc = [[RootViewController alloc]init] ;
    rootVc.fm = [NSFileManager defaultManager] ;
    rootVc.title = @"/" ;
    rootVc.isPoped = NO ;
    UINavigationController *navVc = [[UINavigationController alloc]initWithRootViewController:rootVc] ;
    self.window.rootViewController = navVc ;
    [self.window makeKeyAndVisible] ;
    return YES;
}


@end
