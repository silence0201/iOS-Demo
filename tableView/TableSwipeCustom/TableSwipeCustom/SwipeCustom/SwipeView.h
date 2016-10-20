//
//  SwipeView.h
//  TableSwipeCustom
//
//  Created by 杨晴贺 on 20/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,SwipeEasingFunction){
    SwipeEasingFunctionLinear ,
    SwipeEasingFunctionQuadIn ,
    SwipeEasingFunctionQuadOut ,
    SwipeEasingFunctionQuadInOut ,
    SwipeEasingFunctionCubicIn ,
    SwipeEasingFunctionCubicOut ,
    SwipeEasingFunctionCubicInOut ,
    SwipeEasingFunctionBounceIn ,
    SwipeEasingFunctionBounceOut ,
    SwipeEasingFunctionBounceInOut
};

typedef NS_ENUM(NSUInteger,SwipeViewTransfromMode) {
    SwipeViewTransfromModeDefault ,  // 默认效果,拖拽
    SwipeViewTransfromModeBorder ,  // 渐出
    SwipeViewTransfromMode3D // 3D
};

@interface SwipeView : UIView

@property (nonatomic,assign) CGFloat from ;
@property (nonatomic,assign) CGFloat to ;
@property (nonatomic,assign) CFTimeInterval start ;
@property (nonatomic,assign) CGFloat duration ; // 动画持续的时间,默认是0.3s
@property (nonatomic,assign) SwipeEasingFunction easingFunction ;  //手势动画执行的节奏
@property (nonatomic,assign) SwipeViewTransfromMode mode ;  // 弹出效果


/**
 *  初始化swipeView，添加滑动按钮
 */
- (instancetype)initWithButtons:(NSArray *)buttons fromRight:(BOOL)fromRight cellHeght:(CGFloat)cellHeight;

/**
 *  滑动手势滑动的距离超过swipeView的一半时，会自动显示或隐藏swipeView
 */
- (CGFloat)value:(CGFloat)elapsed duration:(CGFloat)duration from:(CGFloat)from to:(CGFloat)to;

/**
 *  swipeView的弹出、隐藏动画
 *
 *  @param fromRight  右滑
 *  @param t          动画控制量
 *  @param cellHeight cell的高度
 */
- (void)swipeViewAnimationFromRight:(BOOL)fromRight effect:(CGFloat)t cellHeight:(CGFloat)cellHeight;

@end
