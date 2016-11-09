//
//  NumberView.m
//  ShopCartDemo
//
//  Created by 杨晴贺 on 08/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NumberView.h"
#import "UIView+Frame.h"

@interface NumberView ()

@property (nonatomic,strong) UIButton *reduceBtn ;
@property (nonatomic,strong) UIButton *addBtn ;
@property (nonatomic,strong) UILabel *numberLabel  ;

@end

@implementation NumberView

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews] ;
    }
    return self ;
}

- (void)setupSubViews{
    // 减按钮
    self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    self.reduceBtn.frame = CGRectMake(0, 0, 26, 22) ;
    [self.reduceBtn addTarget:self action:@selector(reduceAction:) forControlEvents:UIControlEventTouchUpInside] ;
    self.reduceBtn.tag = 101 ;
    [self.reduceBtn setImage:[UIImage imageNamed:@"jian_icon"] forState:UIControlStateNormal] ;
    [self addSubview:self.reduceBtn] ;
    
    UIImageView *numberBg = [[UIImageView alloc]initWithFrame:CGRectMake(self.reduceBtn.right-4, self.reduceBtn.top, 50, 22)] ;
    numberBg.image = [UIImage imageNamed:@"numbe_bg_icon"] ;
    [self addSubview:numberBg] ;
    
    self.numberLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, numberBg.width, numberBg.height)] ;
    self.numberLabel.text = @"1" ;
    self.numberLabel.textAlignment = NSTextAlignmentCenter ;
    self.numberLabel.textColor = [UIColor darkGrayColor] ;
    self.numberLabel.font = [UIFont systemFontOfSize:12] ;
    [numberBg addSubview:self.numberLabel] ;
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    self.addBtn.frame = CGRectMake(numberBg.right-5, self.reduceBtn.top, 26, 22) ;
    self.addBtn.tag = 102 ;
    [self.addBtn setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal] ;
    [self.addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside] ;
    [self addSubview:self.addBtn] ;
}


#pragma mark -- Action
- (void)reduceAction:(UIButton *)reduceBtn{
    if ([self.delegate respondsToSelector:@selector(numberView:reductAction:)]) {
        [self.delegate numberView:self reductAction:reduceBtn] ;
    }
}

- (void)addAction:(UIButton *)addBtn{
    if ([self.delegate respondsToSelector:@selector(numberView:addAction:)]) {
        [self.delegate numberView:self addAction:addBtn] ;
    }
}

#pragma mark -- set
- (void)setNumberStr:(NSString *)numberStr{
    _numberStr = numberStr ;
    self.numberLabel.text = numberStr ;
}


@end
