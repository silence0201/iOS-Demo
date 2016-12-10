//
//  UIViewController+EnableDrawer.h
//  DrawerDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (EnableDrawer)

/**
 控制抽屉是否可以打开左侧页面
 
 @param enable YES:打开
 */
- (void)enableOpenLeftDrawer:(BOOL)enable ;

/**
 控制抽屉是否可以打开右侧页面
 
 @param enable YES:打开
 */
- (void)enableOpenRightDrawer:(BOOL)enable ;


@end
