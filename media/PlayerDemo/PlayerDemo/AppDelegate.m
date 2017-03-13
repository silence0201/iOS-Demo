//
//  AppDelegate.m
//  PlayerDemo
//
//  Created by 杨晴贺 on 2017/3/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

//  每次试图切换的时候都会走的方法,用于控制设备的旋转方向.
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (_isRotation) {
        return UIInterfaceOrientationMaskLandscape;
    }else {
        return UIInterfaceOrientationMaskPortrait;
    }
    
}


@end
