//
//  CountButton.m
//  countButton
//
//  Created by 杨晴贺 on 8/30/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CountButton.h"

@implementation CountButton{
    NSTimer *_time ;
    NSInteger _timeCount ;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setTitle:@"获取验证码" forState:UIControlStateNormal] ;
        // 设置圆角
        self.layer.cornerRadius = 5.0 ;
        [self setTintColor:[UIColor whiteColor]] ;
        
        // 设置点击事件
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside] ;
        
    }
    
    return self ;
}

- (void)click:(UIButton *)btn{
    if (self.clickButtonAction) {
        self.clickButtonAction() ;
    }
    
    self.selected = YES ;
    self.userInteractionEnabled = NO ;
    _timeCount = self.second ;
    [self setTitle:[NSString stringWithFormat:@"%02ld秒后重新获取",_timeCount] forState:UIControlStateSelected] ;
    _time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeStart) userInfo:nil repeats:YES] ;
}

- (void)timeStart{
    if (_timeCount == 1) {
        _timeCount = _second ;
        [self stop] ;
    }else{
        _timeCount-- ;
        [self setTitle:[NSString stringWithFormat:@"%02ld秒后重新获取",_timeCount] forState:UIControlStateSelected] ;
    }
}

- (void)stop{
    self.selected = NO ;
    self.userInteractionEnabled = YES ;
    if (_time) {
        [_time invalidate] ;// 停止计时器
    }
}

- (void)dealloc{
    if (_time) {
        [_time invalidate] ;
        _time = nil ;
    }
}


@end
