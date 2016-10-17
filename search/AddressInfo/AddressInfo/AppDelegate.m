//
//  AppDelegate.m
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 请求获取位置服务
    CLLocationManager *location = [[CLLocationManager alloc]init] ;
    
    [location requestWhenInUseAuthorization] ;
    
    return YES;
}


@end
