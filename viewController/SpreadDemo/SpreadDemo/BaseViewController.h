//
//  BaseViewController.h
//  SpreadDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface BaseViewController : UIViewController

/**
 *  当前Controller的标题
 *
 *  @return 标题
 */
- (NSString *)controllerTitle ;

/**
 *  初始化View
 */
- (void)initView ;

@property (nonatomic,assign) CGFloat navBarHeight ;

@end
