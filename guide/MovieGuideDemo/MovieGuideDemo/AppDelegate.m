//
//  AppDelegate.m
//  MovieGuideDemo
//
//  Created by 杨晴贺 on 18/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SIMovieGuide.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL isFirstLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLogin"] boolValue];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    if (!isFirstLogin) {
        SIMovieGuide *guide = [[SIMovieGuide alloc]init] ;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"] ;
        if (path) {
            guide.movieURL = [NSURL fileURLWithPath:path] ;
        }
        
        guide.enterBlock = ^(SIMovieGuide *guide){
            [guide presentViewController:[ViewController new] animated:YES completion:nil] ;
        } ;
        //是第一次
        self.window.rootViewController = guide;
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFirstLogin"];
    }else{
        //不是首次启动
        ViewController *viewCtrl = [[ViewController alloc]init];
        self.window.rootViewController = viewCtrl;
    }
    [self.window makeKeyAndVisible] ;
    return YES;
}



@end
