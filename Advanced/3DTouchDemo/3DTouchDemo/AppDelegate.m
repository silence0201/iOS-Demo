//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by 杨晴贺 on 9/13/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <SafariServices/SafariServices.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

// 可以在这里代码设置或者在plist设置
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 3DTouch 分为重压和轻压,分别称作POP(第一段重压)和PEEK(第二段重压),外面的图标只需要POP即可
    // POP手势图标初始化
    
    // 使用系统自带的图标
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] ;
    
    // 使用自己的图片,尺寸大小为35X35 需要2X 3X图 具体根据自己需要来
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"test"] ;
    
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc]initWithType:@"item1" localizedTitle:@"gitHub" localizedSubtitle:nil icon:icon1 userInfo:nil] ;
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc]initWithType:@"item2" localizedTitle:@"主页" localizedSubtitle:nil icon:icon2 userInfo:nil] ;
    
    NSArray *array = @[item1,item2] ;
    
    [UIApplication sharedApplication].shortcutItems = array ;
    
    
    return YES;
}

#pragma mark - 3DTouch触发的方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.type isEqualToString:@"item1"]) {
        SFSafariViewController *sv = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://github.com/silence0201"]] ;
        self.window.rootViewController = sv ;
        NSLog(@"按压了item1") ;
    }else if([shortcutItem.type isEqualToString:@"item2"]){
        NSLog(@"按压了item2") ;
    }else if([shortcutItem.type isEqualToString:@"item3"]){
        ViewController *vc = (ViewController *)self.window.rootViewController ;
        SFSafariViewController *sv = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://github.com/silence0201"]] ;
        [vc presentViewController:sv animated:YES completion:^{
            NSLog(@"打开成功") ;
        }] ;
    }
}



@end
