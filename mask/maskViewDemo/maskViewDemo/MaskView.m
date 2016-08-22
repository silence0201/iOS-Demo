//
//  MaskView.m
//  maskViewDemo
//
//  Created by 杨晴贺 on 8/22/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MaskView.h"

@interface MaskView ()

@property (nonatomic,strong) UIView *contentView ;

@end


@implementation MaskView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self layoutAllSubviews] ;
    }
    return self ;
}

- (void)layoutAllSubviews{
    /*创建灰色背景*/
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.alpha = 0.3;
    bgView.backgroundColor = [UIColor blackColor];
    [self addSubview:bgView];
    
    
    /*添加手势事件,移除View*/
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissContactView:)];
    [bgView addGestureRecognizer:tapGesture];
    
}

#pragma mark - 手势点击事件,移除View
- (void)dismissContactView:(UITapGestureRecognizer *)tapGesture{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view{
    [view addSubview:self] ;
    [self show] ;
}

- (void)show{
    /*创建显示View*/
    _contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(0, 0, 100, 100);
    _contentView.center = self.superview.center ;
    _contentView.backgroundColor=[UIColor whiteColor];
    _contentView.layer.cornerRadius = 4;
    _contentView.layer.masksToBounds = YES;
    [self addSubview:_contentView];
    /*可以继续在其中添加一些View*/
}


@end
