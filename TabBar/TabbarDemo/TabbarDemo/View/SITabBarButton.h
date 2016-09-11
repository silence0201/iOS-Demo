//
//  SITabBarButton.h
//  TabbarDemo
//
//  Created by 杨晴贺 on 9/11/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TabItemBadgeStyle) {
    TabItemBadgeStyleNone = 0 , // 默认样式
    TabItemBadgeStyleNumber = 1 , // 数字样式
    TabItemBadgeStyleDot = 2, // 小圆点
};

@interface SITabBarButton : UIButton

@property (nonatomic,assign) TabItemBadgeStyle badgeStyle ;
@property (nonatomic,assign) NSInteger badge ;
@property (nonatomic,assign) BOOL isHideBadgeBtn ;

@end
