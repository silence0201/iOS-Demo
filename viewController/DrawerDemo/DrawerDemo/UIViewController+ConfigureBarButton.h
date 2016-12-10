//
//  UIViewController+ConfigureBarButton.h
//  DrawerDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonActionBlock)();

@interface UIViewController (ConfigureBarButton)

/**
 *  设置带文字的左导航按钮并且回调方法
 *
 *  @param title 设置左侧导航按钮的文字内容
 *  @param action 回调方法
 */
- (void)configureLeftBarButtonWithTitle:(NSString *)title action:(ButtonActionBlock)action;

/**
 *  设置带文字的右导航按钮并且回调方法
 *
 *  @param title 设置右侧导航按钮的文字内容
 *  @param action 回调方法
 */
- (void)configureRightBarButtonWithTitle:(NSString *)title action:(ButtonActionBlock)action;

@end
