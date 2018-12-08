//
//  ViewController.m
//  FloatWindow
//
//  Created by Silence on 2018/12/8.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "DYYFloatWindow.h"

@interface ViewController ()

@property(nonatomic,strong) DYYFloatWindow *floatWindow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showFloatWindow];
}

- (void)showFloatWindow{
    _floatWindow = [[DYYFloatWindow alloc]initWithFrame:CGRectMake(0, 200, 50, 50) mainImageName:@"z.png" imagesAndTitle:@{@"ddd":@"用户中心",@"eee":@"退出登录",@"fff":@"客服中心"} bgcolor:[UIColor lightGrayColor] animationColor:[UIColor purpleColor]];
    _floatWindow.clickBolcks = ^(NSInteger i){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"第 %ld 个按钮",i] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    };
    
    [_floatWindow showWindow];
}


@end
