//
//  PresentOneTransition.m
//  PresentOneControllerDemo
//
//  Created by 杨晴贺 on 05/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "PresentOneTransition.h"
#import "UIView+FrameChange.h"

@interface PresentOneTransition ()


/** 类型 */
@property (nonatomic,assign) PresentOneTransitionStyle type ;

@end

@implementation PresentOneTransition

+ (instancetype)transitionWithTransitionType:(PresentOneTransitionStyle)type{
    return [[self alloc]initWithTransitionType:type] ;
}

- (instancetype)initWithTransitionType:(PresentOneTransitionStyle)type{
    if(self = [super init]){
        _type = type ;
    }
    return self ;
}

// 时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _type == PresentOneTransitionStylePresent ? 0.5 : 0.25;
}

// 动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case PresentOneTransitionStylePresent:
            [self presentAnimation:transitionContext] ;
            break ;
        case PresentOneTransitionStyleDismiss:
            [self dismissAnimation:transitionContext] ;
            break ;
    }
}

/** 实现present动画 */
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 通过viewControllerForKey取出转场前后的两个控制器
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] ;
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] ;
    // 对原始的VC截图
    UIImageView *snapView = [[UIImageView alloc]initWithImage:[self imageFromView:fromVc.view]] ;
    snapView.frame = fromVc.view.frame ;
    // 因为对截图做动画，fromVc就可以隐藏了
    fromVc.view.hidden = YES ;
    // 如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理者所有做转场动画的视图
    UIView *containerView = [transitionContext containerView] ;
    // 将截图视图和toVc的view都加入ContainerView中
    [containerView addSubview:snapView] ;
    [containerView addSubview:toVc.view] ;
    // 设置toVc的frame，因为这里ToVc present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
    toVc.view.frame = CGRectMake(0, containerView.height, containerView.width, 450) ;
    // 开始动画，使用产生弹簧效果的动画API
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.55
          initialSpringVelocity:1.0 / 0.55
                        options:0
                     animations:^{
        // 首先我们让toVc向上移动
        toVc.view.transform = CGAffineTransformMakeTranslation(0, -450);
        // 然后让截图视图缩小一点即可
        snapView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不是用手势的话直接传YES也是可以的，我们必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在，会出现无法交互的情况，切记
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        // 转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            //失败后，我们要把fromVc显示出来
            fromVc.view.hidden = NO;
            //然后移除截图视图，因为下次触发present会重新截图
            [snapView removeFromSuperview];
        }
    }];

    
}

/** 实现dimiss动画 */
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //注意在dismiss的时候fromVc和toVc相反了
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 参照present动画逻辑进行还原
    UIView *containerView = [transitionContext containerView] ;
    NSArray *subviewsArray = containerView.subviews;
    UIView *snapView = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];
    // 动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVc.view.transform = CGAffineTransformIdentity;
        snapView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            //失败了接标记失败
            [transitionContext completeTransition:NO];
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
            toVc.view.hidden = NO;
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
