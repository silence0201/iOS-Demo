//
//  AppDelegate.m
//  versionUpdate
//
//  Created by 杨晴贺 on 25/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "VersionUpdateFunction.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [VersionUpdateFunction versionUpdate] ;
}



@end
