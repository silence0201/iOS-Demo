//
//  SITopDisplayItem.m
//  SITopDisplay
//
//  Created by 杨晴贺 on 27/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SITopDisplayItem.h"

@implementation SITopDisplayItem{
    UIImage *defaultBackgroundImage ;
    UIFont *amplifyFont ;
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title defaultBackgroundImage:(UIImage *)backgroundImage{
    if(self = [super initWithFrame:frame]){
        // 设置背景图片
        self.backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.3, 0, frame.size.width-0.6, frame.size.height)] ;
        defaultBackgroundImage = backgroundImage ;
        self.backgroundImageView.image = defaultBackgroundImage ;
        [self addSubview:self.backgroundImageView] ;
        
        // 设置标题
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.3, 0, frame.size.width-0.6, frame.size.height)] ;
        self.titleLabel.text = title ;
        self.titleLabel.backgroundColor = [UIColor clearColor] ;
        self.titleLabel.numberOfLines = 2 ;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping ;
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f] ;
        self.titleLabel.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:self.titleLabel] ;
        
        // 添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)] ;
        [self addGestureRecognizer:tap] ;
    }
    return self ;
}

- (void)tapAction{
    NSLog(@"%s",__func__) ;
    if([self.delegate respondsToSelector:@selector(didSelectedOnItem:)]){
        [self.delegate didSelectedOnItem:self] ;
    }
}

- (void)switchToNormal{
    self.titleLabel.font = self.titleFont ;
    if (self.normalColor) {
        self.titleLabel.textColor = self.normalColor ;
    }else{
        // 设置默认颜色
        self.titleLabel.textColor = [UIColor blackColor] ;
    }
    
    // 设置背景颜色
    if(self.unSelectedBackgroundImage){
        self.backgroundImageView.image = self.unSelectedBackgroundImage ;
    }else{
        self.backgroundImageView.image = defaultBackgroundImage ;
    }
}

- (void)switchToSelected{
    if(self.amplifySelectedTitle){
        if(!amplifyFont){
            amplifyFont = [UIFont boldSystemFontOfSize:self.titleFont.pointSize + 2] ;
        }
        self.titleLabel.font = amplifyFont ;
    }
    
    // 设置title的颜色
    if(self.selectedColor){
        self.titleLabel.textColor = self.selectedColor ;
    }else{
        self.titleLabel.textColor = [UIColor blueColor] ;
    }
    
    // 设置背景颜色
    if (self.selectedBackgroundImage) {
        self.backgroundImageView.image = self.selectedBackgroundImage ;
    }else{
        self.backgroundImageView.image = defaultBackgroundImage ;
    }
}

- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor ;
    if (normalColor) {
        self.titleLabel.textColor = normalColor ;
    }
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont ;
    if (titleFont) {
        self.titleLabel.font = titleFont ;
    }
}

@end
