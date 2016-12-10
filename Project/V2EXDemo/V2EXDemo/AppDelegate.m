//
//  AppDelegate.m
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"

#import "MSGStatusToast.h"
#import "Reachability.h"

#import "HomeViewController.h"
#import "LeftMenuViewController.h"

#import "MMDrawerController.h"

@interface AppDelegate (){
    MMDrawerController *_homeDrawerController ;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    
    HomeViewController *homeVc = [[HomeViewController alloc]init] ;
    
    UINavigationController *navVc = [[UINavigationController alloc]initWithRootViewController:homeVc] ;
    UINavigationBar *appearance = [UINavigationBar appearance] ;
    [appearance setTintColor:[UIColor whiteColor]];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],
                                        NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:15],
                                        NSFontAttributeName, nil]];
    [appearance setBarTintColor:[UIColor cyanColor]] ;
    
    LeftMenuViewController *leftMenuVc = [[LeftMenuViewController alloc]init] ;
    _homeDrawerController = [[MMDrawerController alloc]initWithCenterViewController:navVc leftDrawerViewController:leftMenuVc] ;
    [_homeDrawerController setMaximumLeftDrawerWidth:90.0f] ;
    [_homeDrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll] ;
    [_homeDrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll] ;
    
    self.window.rootViewController = _homeDrawerController ;
    [self.window makeKeyAndVisible] ;
    return YES;
}

@end
