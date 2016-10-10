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
                switch (err.code) {
                    case LAErrorAuthenticationFailed:
                        NSLog(@"LAErrorSystemCancel");
                        break;
                        //用户取消
                    case LAErrorUserCancel:
                        NSLog(@"LAErrorUserCancel");
                        break;
                        //验证失败
                    case LAErrorUserFallback:
                        NSLog(@"LAErrorUserFallback");

                        break;
                    case LAErrorSystemCancel:
                        NSLog(@"LAErrorAppCancel");
                        break;
                    case LAErrorPasscodeNotSet:
                        NSLog(@"LAErrorSystemCancel");
                        break;
                        //用户取消
                    case LAErrorTouchIDNotAvailable:
                        NSLog(@"LAErrorUserCancel");
                        break;
                        //验证失败
                    case LAErrorTouchIDNotEnrolled:
                        NSLog(@"LAErrorUserFallback");
                        break;
                    case LAErrorTouchIDLockout:
                        NSLog(@"LAErrorAppCancel");
                        break;
                    case LAErrorAppCancel:
                        NSLog(@"LAErrorAppCancel");
                        break;
                    case LAErrorInvalidContext:
                        NSLog(@"LAErrorAppCancel");
                        break;
                    default:
                        break;
                }

            }
        }] ;
    }else{
        NSLog(@"不支持指纹解锁") ;
    }
}

@end
