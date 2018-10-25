//
//  ViewController.m
//  FaceIDDemo
//
//  Created by Silence on 2018/10/25.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "SuccessViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@property (nonatomic, strong) LAContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *authentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    NSString *text = @"不支持生物识别";
    NSError *error;
    if ([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        BOOL faceID = self.context.biometryType == LABiometryTypeFaceID ;
        text = faceID ? @"使用FaceID解锁" : @"使用指纹解锁" ;
        [authentBtn addTarget:self action:@selector(authentAction) forControlEvents:UIControlEventTouchUpInside];
    }
    [authentBtn setTitle:text forState:UIControlStateNormal];
    [authentBtn sizeToFit];
    authentBtn.center = self.view.center;
    [self.view addSubview:authentBtn];
}

- (LAContext *)context {
    if (!_context) {
        _context = [[LAContext alloc]init];
    }
    return _context;
}

- (void)authentAction {
    NSError *error ;
    BOOL canAuthentication = [self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
    if (canAuthentication) {
        [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"使用生物识别解锁" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:[SuccessViewController new] animated:YES];
                });
                
            }else {
                NSLog(@"%@",error);
            }
        }];
    }
}


@end
