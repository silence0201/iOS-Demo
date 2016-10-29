//
//  BouncePresentAnimation.m
//  ModelTransitionDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "BouncePresentAnimation.h"

@implementation BouncePresentAnimation

// 上下文切换需要的时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.8f ;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 获取ViewController
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] ;
    
    // 设置Frame
    CGRect screenBounds = [UIScreen mainScreen].bounds ;
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVc] ;
    toVc.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height) ;
    
    // 添加到containerView
    UIView *containerView = [transitionContext containerView] ;
    [containerView addSubview:toVc.view] ;
    
    // animation
    NSTimeInterval duration = [self transitionDuration:transitionContext] ;
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toVc.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         // 通知context结束
                         [transitionContext completeTransition:YES];
                     }];
}



@end
