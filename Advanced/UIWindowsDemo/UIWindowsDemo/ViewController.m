//
//  ViewController.m
//  UIWindowsDemo
//
//  Created by Silence on 2017/12/7.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(strong,nonatomic)UIWindow *window;
@property(strong,nonatomic)UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(createButton) withObject:nil afterDelay:1];  
}

- (void)createButton{
    _button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [_button addTarget:self action:@selector(resignWindow) forControlEvents:UIControlEventTouchUpInside];
    _window = [[UIWindow alloc]initWithFrame:CGRectMake(100, 200, 80, 80)];
    _window.windowLevel = UIWindowLevelAlert+1;
    [_window addSubview:_button];
    
    _window.hidden = NO;
    // 等价于,下面这句
    //[_window makeKeyAndVisible];//关键语句,显示window
}

- (void)resignWindow{
    [_window resignKeyWindow];
    _window = nil;
}


@end
