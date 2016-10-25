//
//  MainTabBar.m
//  jianshu
//
//  Created by 杨晴贺 on 25/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabBarButton.h"

@interface MainTabBar ()

@property (nonatomic,strong) NSMutableArray *tabBarButtonArray ;
@property (nonatomic,weak) UIButton *writeButton ;
@property (nonatomic,weak) MainTabBarButton *selectedButton ;

@end

@implementation MainTabBar

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor] ;
        [self setupWrite] ;
    }
    return self ;
}

- (void)setupWrite{
    UIButton *writeButton = [[UIButton alloc]init] ;
    writeButton.adjustsImageWhenHighlighted = NO ;
    [writeButton setBackgroundImage:[UIImage imageNamed:@"button_write~iphone"] forState:UIControlStateNormal] ;
    [writeButton addTarget:self action:@selector(clickWriteButton) forControlEvents:UIControlEventTouchUpInside] ;
    writeButton.bounds = CGRectMake(0, 0, writeButton.currentBackgroundImage.size.width, writeButton.currentBackgroundImage.size.height) ;
    [self addSubview:writeButton] ;
    _writeButton = writeButton ;
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem{
    MainTabBarButton *tabBarBtn = [[MainTabBarButton alloc]init] ;
    tabBarBtn.tabBarItem = tabBarItem ;
    [tabBarBtn addTarget:self action:@selector(clickTabBarButton:) forControlEvents:UIControlEventTouchUpInside] ;
    [self addSubview:tabBarBtn] ;
    [self.tabBarButtonArray addObject:tabBarBtn] ;
    
    // 默认选择第一个
    if(self.tabBarButtonArray.count == 1){
        [self clickTabBarButton:tabBarBtn] ;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews] ;
    self.writeButton.center = self.center ;
    
    CGFloat btnY = 0 ;
    CGFloat btnW = self.frame.size.width / self.subviews.count ;
    CGFloat btnH = self.frame.size.height ;
    
    for (NSInteger nIndex = 0; nIndex < self.tabBarButtonArray.count; nIndex++) {
        CGFloat btnX = btnW *nIndex ;
        MainTabBarButton *tabBarBtn = self.tabBarButtonArray[nIndex] ;
        if(nIndex > 1){
            btnX += btnW ;
        }
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH) ;
        tabBarBtn.tag = nIndex ;
    }
}

- (NSMutableArray *)tabBarButtonArray{
    if (!_tabBarButtonArray) {
        _tabBarButtonArray = [NSMutableArray array] ;
    }
    return _tabBarButtonArray ;
}

- (void)clickWriteButton{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBarClickWriteButton:self] ;
    }
}

- (void)clickTabBarButton:(MainTabBarButton *)tabBarBtn{
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]){
        [self.delegate tabBar:self didSelectButtonFrom:self.selectedButton.tag to:tabBarBtn.tag] ;
    }
    
    self.selectedButton.selected = NO ;
    tabBarBtn.selected =YES ;
    self.selectedButton = tabBarBtn ;
}

@end
