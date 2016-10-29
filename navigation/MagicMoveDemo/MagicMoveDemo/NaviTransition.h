//
//  NaviTransition.h
//  MagicMoveDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  动画过渡代理管理的是push还是pop
 */
typedef NS_ENUM(NSUInteger, NaviTransitionType) {
    NaviTransitionTypePush = 0,
    NaviTransitionTypePop
};

@interface NaviTransition : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(NaviTransitionType)type;
- (instancetype)initWithTransitionType:(NaviTransitionType)type;

@end
