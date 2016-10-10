//
//  SILockTool.m
//  TouchID
//
//  Created by 杨晴贺 on 09/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SILockTool.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation SILockTool

+ (void)unLockWithTip:(NSString *)tipStr{
    LAContext *context = [[LAContext alloc]init] ;
    NSError *err = nil ;
    
    // 判断设备是否支持指纹解锁
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err]){
        NSLog(@"支持指纹解锁") ;
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:tipStr reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功") ;
            }else{
                //验证失败的几种情况
                switch (error.code) {
                    case LAErrorSystemCancel:
                        NSLog(@"系统取消验证") ;
                        break;
                    case LAErrorUserCancel:
                        NSLog(@"用户取消验证") ;
                        break ;
                    case LAErrorUserFallback:
                        NSLog(@"用户选择输入密码处理") ;
                        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                            // 用户选择输入密码,切换到主线程处理
                            NSLog(@"请输入密码") ;
                        }] ;
                        break ;
                    default:
                        NSLog(@"Other") ;
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                            NSLog(@"发出提示") ;
                        }];
                        break;
                }

            }
        }] ;
    }else{
        NSLog(@"不支持指纹解锁") ;
        switch (err.code) {
            case LAErrorTouchIDNotEnrolled:
                NSLog(@"用户未录入") ;
                break;
            case LAErrorPasscodeNotSet:
                NSLog(@"密码未设置") ;
                break ;
            default:
                NSLog(@"Touch ID 不可用") ;
                break;
        }
    }
}

@end
