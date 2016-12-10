//
//  MSGStatusToast.m
//  MSGStatus
//
//  Created by iurw on 15/9/3.
//  Copyright (c) 2015年 iurw. All rights reserved.
//
#import "AppDelegate.h"
#import "MSGStatusToast.h"
/** 高度 */
#define TOAST_HEIGHT 20

/** 动画时间 */
#define DURATION 0.25

/** 多久隐藏 */
#define HIDE_TIME 2.0

static MSGStatusToast * singleInstance = nil ;



@implementation MSGStatusToast

+ (MSGStatusToast *)shareMSGToast{
    
    @synchronized(self){
        
        if (singleInstance == nil) {
            singleInstance = [[MSGStatusToast alloc] init];
            [singleInstance initWindow];
        }
        
    }
    
    return singleInstance;
}

/** 全局的窗口 */
static UIWindow *_window;
/** 定时器 */
static NSTimer *_timer;

static UILabel *_msgLable;

static UIActivityIndicatorView *_loading;

/**
 * 显示窗口
 */
- (void)initWindow{
    // frame数据
    
    CGRect frame = CGRectMake(0, - TOAST_HEIGHT, [UIScreen mainScreen].bounds.size.width, TOAST_HEIGHT);
    
    // 显示窗口
    _window.hidden = YES;
    _window = [[UIWindow alloc] init];
    _window.backgroundColor = [UIColor whiteColor];
    _window.windowLevel = UIWindowLevelAlert;
    _window.frame = frame;
    _window.hidden = NO;
    
    UITapGestureRecognizer *single = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    single.numberOfTapsRequired=1;
    [_window addGestureRecognizer:single];
    
    _msgLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_window.frame), 30)];
    _msgLable.center = CGPointMake(CGRectGetWidth(_window.frame)/2, CGRectGetHeight(_window.frame)/2);
    _msgLable.font = [UIFont systemFontOfSize:11];
    _msgLable.textAlignment = NSTextAlignmentCenter;
    [_window addSubview:_msgLable];
    
    _loading = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _loading.center = CGPointMake(CGRectGetWidth(_window.frame)/2-55, CGRectGetHeight(_window.frame)/2);
    
    [_window addSubview:_loading];
    
    
}

- (void)showMsg:(NSString *)message autoHide:(BOOL)hide{
    
    [self reduce];
    [_loading stopAnimating];
    _msgLable.text = message;
    _msgLable.textColor = [UIColor whiteColor];
    [self show];
    
    if (hide) {
        [self Timer];
    }
    
}


- (void)showFinish:(NSString *)message autoHide:(BOOL)hide{
    
    [_loading stopAnimating];
    [self reduce];
    _msgLable.text = message;
    _msgLable.textColor = [UIColor greenColor];
    [self show];
    
    if (hide) {
        [self Timer];
    }
    
}

- (void)showError:(NSString *)message autoHide:(BOOL)hide{
    
    [_loading stopAnimating];
    [self reduce];
    _msgLable.text = message;
    _msgLable.textColor = [UIColor redColor];
    [self show];
    
    if (hide) {
        [self Timer];
    }
    
    
}

- (void)showLoadAutoHide:(BOOL)hide{
    
    
    
    [_loading startAnimating];
    [self reduce];
    _msgLable.center = CGPointMake(CGRectGetWidth(_window.frame)/2+10, CGRectGetHeight(_window.frame)/2);
    _msgLable.text = @"数据正在加载...";
    _msgLable.textColor = [UIColor whiteColor];
    [self show];
    
    if (hide) {
        [self Timer];
    }else{
        [_timer invalidate];
    }
    
}



- (void)Timer{
    
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:HIDE_TIME target:self selector:@selector(hide) userInfo:nil repeats:NO];
    
}

- (void)reduce{
    
    _msgLable.center = CGPointMake(CGRectGetWidth(_window.frame)/2, CGRectGetHeight(_window.frame)/2);
    CGRect frame = CGRectMake(0, - TOAST_HEIGHT, [UIScreen mainScreen].bounds.size.width, TOAST_HEIGHT);
    _window.frame = frame;
    
}

- (void)hide{
    
    [UIView animateWithDuration:DURATION animations:^{
        CGRect frame = CGRectMake(0, - TOAST_HEIGHT, [UIScreen mainScreen].bounds.size.width, TOAST_HEIGHT);
        _window.frame = frame;
    }];
    
}

- (void)show{
    
    [UIView animateWithDuration:DURATION animations:^{
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, TOAST_HEIGHT);
        _window.frame = frame;
    }];
    
}


@end
