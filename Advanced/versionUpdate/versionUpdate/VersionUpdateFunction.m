//
//  VersionUpdateFunction.m
//  versionUpdate
//
//  Created by 杨晴贺 on 25/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "VersionUpdateFunction.h"

@implementation VersionUpdateFunction

#pragma mark -- 核心方法:主要通过请求获取对应版本信息
+ (void)versionUpdate{
    // 获取当前发布的版本
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时操作 ---- 获取某个应用在appStore上的信息
        NSString *string  = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=444934666"]
                                                     encoding:NSUTF8StringEncoding error:nil] ;
        if(string != nil){
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding] ;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] ;
            // 版本信息
            NSString *version = [[[dic objectForKey:@"results"]firstObject]objectForKey:@"version"];
            // 更新信息
            NSString *updateInfo = [[[dic objectForKey:@"results"]firstObject]objectForKey:@"releaseNotes"];
            // 获取当前版本
            NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
            
            // 回到主线程更新页面
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新页面
                if(version && ![version isEqualToString:currentVersion]){
                    // 有新版本
                    NSString *message = [NSString stringWithFormat:@"%@\n",updateInfo] ;
                    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"有新版本发布" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往更新", nil] ;
                    [alterView show] ;
                }else{
                    NSLog(@"已经是最新版本了") ;
                }
            }) ;
        }
    }) ;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex) ;
    if (buttonIndex == 1) {
        // app的链接
        NSString *url = @"https://itunes.apple.com/cn/app/qq/id444934666?l=en&mt=8" ;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]] ;
    }
}

@end
