//
//  AppDelegate.m
//  TouchID
//
//  Created by 杨晴贺 on 09/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "SILockTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SILockTool unLockWithTip:@"请输入指纹密码"] ;
    
    return YES;
}


@end
