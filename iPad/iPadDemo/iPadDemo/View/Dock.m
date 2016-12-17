//
//  Dock.m
//  iPadDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "Dock.h"
#import "IconButton.h"

@interface Dock ()<BottomMenuDelegate,TabbarDelegate>

@property (nonatomic,strong) BottomMenu *bottomMenu ;
@property (nonatomic,strong) Tabbar *tabbar ;
@property (nonatomic,strong) IconButton *iconButton ;

@end

@implementation Dock

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.bottomMenu] ;
        [self addSubview:self.tabbar] ;
        [self addSubview:self.iconButton] ;
    }
    return self ;
}

- (BottomMenu *)bottomMenu{
    if (!_bottomMenu) {
        _bottomMenu = [[BottomMenu alloc]init] ;
        _bottomMenu.autoresizingMask = UIViewAutoresizingFlexibleTopMargin ;
        _bottomMenu.delegate = self ;
    }
    return _bottomMenu ;
}

- (Tabbar *)tabbar{
    if (!_tabbar) {
        _tabbar = [[Tabbar alloc]init] ;
        _tabbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin ;
        _tabbar.delegate = self ;
    }
    return _tabbar ;
}

- (IconButton *)iconButton{
    if(!_iconButton){
        _iconButton = [[IconButton alloc]init] ;
    }
    return _iconButton ;
}


- (void)rolateToLandscape:(BOOL)isLandscape{
    // 设置BottomMenu的frame
    [self.bottomMenu rolateToLandscape:isLandscape] ;
    // 设置tabbar的Frame
    [self.tabbar rolateToLandscape:isLandscape] ;
    self.tabbar.top = self.height - self.bottomMenu.height - self.tabbar.height;
    
    // 设置iconlButton的Frame
    [self.iconButton rolateToLandscape:isLandscape] ;
}

- (void)bottomMenu:(BottomMenu *)bottomMenu withType:(BottomMenuType)type{
    if ([self.delegate respondsToSelector:@selector(bottomMenu:withType:)]) {
        [self.delegate bottomMenu:bottomMenu withType:type] ;
    }
}

- (void)tabbar:(Tabbar *)tabbar fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    if([self.delegate respondsToSelector:@selector(tabbar:fromIndex:toIndex:)]){
        [self.delegate tabbar:tabbar fromIndex:fromIndex toIndex:toIndex] ;
    }
}



@end
