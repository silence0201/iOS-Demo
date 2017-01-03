//
//  AppDelegate.m
//  JSPatchDemo
//
//  Created by 杨晴贺 on 03/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "JPEngine.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [JPEngine startEngine] ;
    
    //  这里可以是一个网络接口实现远程控制热更新
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo.js" ofType:nil] ;
    NSError *error ;
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:&error] ;
    if (!error) {
        [JPEngine evaluateScript:script] ;
    }
    return YES;
}


@end
