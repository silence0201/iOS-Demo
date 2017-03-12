//
//  NSArray+Extension.h
//  PlayerDemo
//
//  Created by 杨晴贺 on 2017/3/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end

@interface UISlider (Touch)

/// 单击手势
- (void)addTapGestureWithTarget: (id)target action: (SEL)action;


@end

