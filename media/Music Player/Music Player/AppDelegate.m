//
//  AppDelegate.m
//  Music Player
//
//  Created by 杨晴贺 on 8/4/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置音乐在后台可以播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    //接收远程事件
    [application beginReceivingRemoteControlEvents];
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    //开启后台任务
    [application beginBackgroundTaskWithExpirationHandler:nil];
}


#pragma mark 锁屏按钮的远程通知
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        if (self.remoteBlock) {
            self.remoteBlock(event);
        }
    }
}

@end
