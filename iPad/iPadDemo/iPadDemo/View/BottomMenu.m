//
//  BottomMenu.m
//  iPadDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "BottomMenu.h"

@implementation BottomMenu

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupItemWithImageName:@"tabbar_mood" withType:BottomMenuTypeMood];
        [self setupItemWithImageName:@"tabbar_photo" withType:BottomMenuTypePhoto];
        [self setupItemWithImageName:@"tabbar_blog" withType:BottomMenuTypeBlog];
    }
    return self ;
}

- (void)setupItemWithImageName:(NSString *)imageName withType:(BottomMenuType)type{
    UIButton *item = [[UIButton alloc]init] ;
    [item setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal] ;
    [item setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateHighlighted] ;
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside] ;
    
    item.tag = type ;
    [self addSubview:item] ;
}

- (void)itemClick:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(bottomMenu:withType:)]){
        [self.delegate bottomMenu:self withType:(int)button.tag] ;
    }
}

- (void)rolateToLandscape:(BOOL)isLandscape{
    // 取出item的个数
    NSInteger count = self.subviews.count ;
    
    self.width = self.superview.width ;
    self.height = isLandscape ? kDockItemHeight : kDockItemHeight * count ;
    self.top = self.superview.height - self.height ;
    
    // 给items设置frame
    for(int i = 0 ; i < count ; i++){
        UIButton *item = self.subviews[i] ;
        item.width = isLandscape ? self.width / 3 : self.width ;
        item.height = kDockItemHeight ;
        item.left = isLandscape ? item.width * i : 0 ;
        item.top  = isLandscape ? 0 :item.height * i ;
    }
}

@end
