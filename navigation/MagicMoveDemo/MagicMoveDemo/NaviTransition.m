//
//  NaviTransition.m
//  MagicMoveDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NaviTransition.h"
#import "MagicMoveViewController.h"
#import "MagicMovePushViewController.h"
#import "MagicMoveCell.h"

@interface NaviTransition ()

/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) NaviTransitionType type;

@end

@implementation NaviTransition

- (instancetype)initWithTransitionType:(NaviTransitionType)type{
    if (self = [super init]) {
        _type = type ;
    }
    return self ;
}

+ (instancetype)transitionWithType:(NaviTransitionType)type{
    return [[self alloc]initWithTransitionType:type] ;
}

// 动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.75 ;
}

// 动画的执行
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case NaviTransitionTypePush:
            [self pushAnimation:transitionContext] ;
            break ;
        case NaviTransitionTypePop:
            [self popAnimation:transitionContext] ;
            break ;
    }
}

#pragma mark -- Animation
- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    MagicMoveViewController *fromVc = (MagicMoveViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] ;
    MagicMovePushViewController *toVc = (MagicMovePushViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] ;
    
    MagicMoveCell *cell = (MagicMoveCell *)[fromVc.collectionView cellForItemAtIndexPath:fromVc.currentIndexPath] ;
    UIView *containerView = [transitionContext containerView] ;
    
    UIImage *image = [self imageFromView:cell.imageView];
    UIImageView *snapView = [[UIImageView alloc] initWithImage:image];
    snapView.frame =  [cell.imageView convertRect:cell.imageView.bounds toView: containerView];
    [containerView addSubview:snapView];
    
    //设置动画前的各个控件的状态
    cell.imageView.hidden = YES;
    toVc.view.alpha = 0;
    toVc.imageView.image = cell.imageView.image ;
    toVc.imageView.hidden = YES;
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containerView addSubview:toVc.view];
    [containerView addSubview:snapView];
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        snapView.frame = [toVc.imageView convertRect:toVc.imageView.bounds toView:containerView];
        toVc.view.alpha = 1;
    } completion:^(BOOL finished) {
        snapView.hidden = YES;
        toVc.imageView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
    
}


- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    MagicMovePushViewController *fromVc = (MagicMovePushViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] ;
    MagicMoveViewController *toVc = (MagicMoveViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] ;
    
    MagicMoveCell *cell = (MagicMoveCell *)[toVc.collectionView cellForItemAtIndexPath:toVc.currentIndexPath] ;
    UIView *containerView = [transitionContext containerView] ;
    // 这里的lastView就是push时候初始化的那个tempView
    UIView *snapView = containerView.subviews.lastObject;
    // 设置初始状态
    cell.imageView.hidden = YES ;
    fromVc.imageView.hidden = YES ;
    snapView.hidden = NO ;
    [containerView insertSubview:toVc.view atIndex:0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.55
          initialSpringVelocity:1 / 0.55
                        options:0
                     animations:^{
        snapView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        fromVc.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            snapView.hidden = YES;
            fromVc.imageView.hidden = NO;
        }else{//手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            cell.imageView.hidden = NO;
            [snapView removeFromSuperview];
        }
    }];
}

#pragma mark -- 截取View
- (UIImage *)imageFromView:(UIView *)snapView {
    UIGraphicsBeginImageContext(snapView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [snapView.layer renderInContext:context];
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}
@end
