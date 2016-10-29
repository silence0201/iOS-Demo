//
//  NormalDismissAnimation.m
//  ModelTransitionDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NormalDismissAnimation.h"

@implementation NormalDismissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.8f ;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 获取控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] ;
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] ;
    
    // 设置frame
    CGRect screenBounds = [UIScreen mainScreen].bounds ;
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVc] ;
    CGRect finaFrame = CGRectOffset(initFrame, 0, screenBounds.size.height) ;
    
    // 添加到Container View
    UIView *containerView = [transitionContext containerView] ;
    [containerView addSubview:toVc.view] ;
    [containerView sendSubviewToBack:toVc.view] ;
    
    // animation
    NSTimeInterval duration = [self transitionDuration:transitionContext] ;
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.view.frame = finaFrame;
                     } completion:^(BOOL finished) {
                         // 通知context结束
                         [transitionContext completeTransition:YES];
                     }];
}

@end
