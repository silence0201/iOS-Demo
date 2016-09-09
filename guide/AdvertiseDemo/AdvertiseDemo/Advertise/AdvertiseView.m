//
//  AdvertiseView.m
//  AdvertiseDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AdvertiseView.h"

@interface AdvertiseView ()

@property (nonatomic,strong) UIImageView *advertiseView ;
@property (nonatomic,strong) UIButton *countBtn ;
@property (nonatomic,strong) NSTimer *countTimer ;
@property (nonatomic,assign) NSInteger count ;

@end

@implementation AdvertiseView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 广告图片
        _advertiseView = [[UIImageView alloc]initWithFrame:frame] ;
        _advertiseView.userInteractionEnabled = YES ;
        _advertiseView.contentMode = UIViewContentModeScaleAspectFill ;
        _advertiseView.clipsToBounds = YES ;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToAdd)] ;
        [_advertiseView addGestureRecognizer:tap] ;
        
        // 跳过按钮
        CGFloat btnWidth = 60 ;
        CGFloat btnHeight = 30 ;
        _countBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-btnWidth-24, 30, btnWidth, btnHeight) ] ;
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside] ;
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15] ;
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
        _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6] ;
        _countBtn.layer.cornerRadius = 4 ;
        
        [self addSubview:_advertiseView] ;
        [self addSubview:_countBtn] ;
    }
    return self ;
}

#pragma mark - public Method
- (void)show{
    [self startTimer] ;
    UIWindow *window = [UIApplication sharedApplication].keyWindow ;
    [window.rootViewController.view addSubview:self] ;
}

#pragma makr - Action
// 定时器方法
- (void)countDown{
    _count -- ;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%ld",_count] forState:UIControlStateNormal] ;
    if (_count == 0) {
        [self dismiss] ;
    }
}

// 跳转到对应的广告页面
- (void)pushToAdd{
    [self dismiss] ;
    // 发送跳转到广告页面的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushtoad" object:nil] ;
}

// 移除广告页面
- (void)dismiss{
    [self.countTimer invalidate] ;
    self.countTimer = nil ;
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0 ;
    } completion:^(BOOL finished) {
        [self removeFromSuperview] ;
    }] ;
}

#pragma mark - lazy load
- (NSTimer *)countTimer{
    if(!_countTimer){
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES] ;
    }
    return _countTimer ;
}

#pragma mark - set Method
- (void)setFilePath:(NSString *)filePath{
    _filePath = filePath ;
    _advertiseView.image = [UIImage imageWithContentsOfFile:filePath] ;
}

#pragma mark - private Method
- (void)startTimer{
    _count = self.showTime ;
    [[NSRunLoop mainRunLoop]addTimer:self.countTimer forMode:NSRunLoopCommonModes] ;
}


@end
