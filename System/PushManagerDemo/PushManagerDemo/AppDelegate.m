//
//  AppDelegate.m
//  PushManagerDemo
//
//  Created by Silence on 2017/12/24.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AppDelegate.h"
#import "SIPushNotificationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[SIPushNotificationManager sharedInstance] requestAuthorizationPushNotificationWithCompletion:^(BOOL succeed) {
        if (succeed) {
            NSLog(@"获取推送权限成功");
        }else {
            NSLog(@"获取推送权限失败");
        }
    }];
    return YES;
}



@end
