//
//  SITabBar.m
//  TabbarDemo
//
//  Created by 杨晴贺 on 9/11/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SITabBar.h"
#import "SITabBarButton.h"


#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface SITabBar ()

@property (nonatomic,weak) UIButton *selectButton ;

@end

@implementation SITabBar

#pragma mark - 重写set方法
- (void)setControllers:(NSArray *)controllers{
    _controllers = controllers ;
    CGFloat viewWidth = self.frame.size.width / controllers.count ;
    NSMutableArray *items = [NSMutableArray array] ;
    for(NSInteger i = 0 ; i<_controllers.count;i++){
        UIViewController *vc = _controllers[i] ;
        SITabBarButton *btn = [[SITabBarButton alloc]initWithFrame:CGRectMake(viewWidth * i, 0, viewWidth, 49)] ;
        btn.tag = 100 + i ;
        //设置图片
        [btn setImage:vc.tabBarItem.image forState:UIControlStateNormal] ;
        [btn setImage:vc.tabBarItem.selectedImage forState:UIControlStateSelected] ;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        
        // 设置字体的颜色
        [btn setTitle:vc.tabBarItem.title forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(51, 153, 255, 1) forState:UIControlStateSelected];
        
        if (btn.tag == 100) {
            btn.selected = YES ;
            self.selectButton = btn ;
        }
        [self addSubview:btn] ;
        [items addObject:btn] ;
    }
    self.items = items ;
}

#pragma mark - Action
- (void)btnClick:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = YES ;
        self.selectButton.selected = NO ;
        self.selectButton = btn ;
    }
    
    if (self.clickBlock) {
        self.clickBlock(btn.tag - 100) ;
    }
}



@end
