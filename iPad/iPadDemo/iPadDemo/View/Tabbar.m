//
//  Tabbar.m
//  iPadDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "Tabbar.h"

const CGFloat kRatio = 0.4;

@implementation Tabbar{
    TabbarItem *_selectedItem ;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupWithImageIcon:@"tab_bar_feed_icon" title:@"全部动态"];
        [self setupWithImageIcon:@"tab_bar_passive_feed_icon" title:@"与我相关"];
        [self setupWithImageIcon:@"tab_bar_pic_wall_icon" title:@"照片墙"];
        [self setupWithImageIcon:@"tab_bar_e_album_icon" title:@"电子相框"];
        [self setupWithImageIcon:@"tab_bar_friend_icon" title:@"好友"];
        [self setupWithImageIcon:@"tab_bar_e_more_icon" title:@"更多"];
    }
    return self ;
}

- (void)setupWithImageIcon:(NSString *)iconName title:(NSString *)title{
    TabbarItem *item = [[TabbarItem alloc]init] ;
    [item setImage:[UIImage imageNamed:iconName]forState:UIControlStateNormal] ;
    [item setTitle:title forState:UIControlStateNormal] ;
    [item setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
    
    item.tag = self.subviews.count ;
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside] ;
    [self addSubview:item] ;
}

- (void)itemClick:(TabbarItem *)item{
    if([self.delegate respondsToSelector:@selector(tabbar:fromIndex:toIndex:)]){
        [self.delegate tabbar:self fromIndex:_selectedItem.tag toIndex:item.tag] ;
    }
    _selectedItem.selected = NO ;
    _selectedItem = item ;
    _selectedItem.selected = YES ;
    
}

-(void)rolateToLandscape:(BOOL)isLandscape{
    NSInteger count = self.subviews.count ;
    
    // 给自身设置frame
    self.width = self.superview.width ;
    self.height = kDockItemHeight * 6 ;
    
    // 给字view设置frame
    for(int i = 0 ; i < count ; i++){
        UIButton *item = self.subviews[i] ;
        item.width = self.width ;
        item.height = kDockItemHeight ;
        item.left = 0 ;
        item.top = item.height * i ;
    }
}

- (void)unSelected{
    _selectedItem.selected = NO ;
}

@end

@implementation TabbarItem

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.imageView.contentMode = UIViewContentModeCenter ;
    }
    return self ;
}

- (void)setHighlighted:(BOOL)highlighted{}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if(self.width == self.height){
        return CGRectMake(0, 0, -1, -1) ;
    }else{
        CGFloat width = self.width * (1 - kRatio);
        CGFloat height = self.height;
        CGFloat x = self.width * kRatio;
        CGFloat y = 0;
        return CGRectMake(x, y, width, height);
    }
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (self.width == self.height) {
        return self.bounds ;
    }else{
        CGFloat width = self.width * kRatio;
        CGFloat height = self.height;
        CGFloat x = 0;
        CGFloat y = 0;
        return CGRectMake(x, y, width, height);
    }
}
@end
