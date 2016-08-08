//
//  AppDelegate.m
//  guidePageDemo
//
//  Created by 杨晴贺 on 8/8/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideView.h"

static NSString * const everLaunched = @"everLaunched" ;
static NSString * const firstLaunch = @"firstLaunch" ;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 这里对第一次启动进行判断,如果第一次就直接启动否则显示引导页面
    if(![[NSUserDefaults standardUserDefaults] boolForKey:everLaunched]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:everLaunched] ;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:firstLaunch] ;
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:firstLaunch] ;
    }
    
    // 进行判断并显示
    if ([[NSUserDefaults standardUserDefaults] boolForKey:firstLaunch]) {
        GuideView *guideView = [[GuideView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) ];
        [self.window.rootViewController.view addSubview:guideView] ;
        
        [UIView animateWithDuration:0.25 animations:^{
            guideView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) ;
        }];
    }
    
    return YES;
}


@end
