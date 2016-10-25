//
//  MainTabBarButton.m
//  jianshu
//
//  Created by 杨晴贺 on 25/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MainTabBarButton.h"

// image ratio
#define TabBarButtonImageRatio 0.6

@implementation MainTabBarButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        self.imageView.contentMode = UIViewContentModeBottom ;
        self.titleLabel.textAlignment = NSTextAlignmentCenter ;
        self.titleLabel.font = [UIFont systemFontOfSize:12] ;
        [self setTitleColor:[UIColor colorWithRed:205/255.0 green:89/225.0 blue:75/255.0 alpha:1] forState:UIControlStateSelected] ;
        [self setTitleColor:[UIColor colorWithRed:117/255.0f green:117/255.0f blue:117/255.0f alpha:1.0] forState:UIControlStateNormal];
    }
    return self ;
}

// 取消高亮状态
- (void)setHighlighted:(BOOL)highlighted{}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width ;
    CGFloat imageH = contentRect.size.height * TabBarButtonImageRatio;
    
    return CGRectMake(0, 0, imageW, imageH) ;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * TabBarButtonImageRatio ;
    CGFloat titleW = contentRect.size.width ;
    CGFloat titleH = contentRect.size.height - titleY ;
    
    return CGRectMake(0, titleY, titleW, titleH) ;
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem{
    _tabBarItem = tabBarItem ;
    
    [self setTitle:tabBarItem.title forState:UIControlStateNormal] ;
    [self setImage:tabBarItem.image forState:UIControlStateNormal] ;
    [self setImage:tabBarItem.selectedImage forState:UIControlStateSelected] ;
}

@end
