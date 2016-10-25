//
//  MainTabBar.h
//  jianshu
//
//  Created by 杨晴贺 on 25/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainTabBar ;

@protocol MainTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MainTabBar *)tabBar didSelectButtonFrom:(long)fromBtnTag to:(long)toBtnFlag ;
- (void)tabBarClickWriteButton:(MainTabBar *)tabBar ;

@end

@interface MainTabBar : UIView

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem ;
@property (nonatomic,weak) id<MainTabBarDelegate> delegate ;

@end
