//
//  RoundRectPresentationController.m
//  PresentBottomDemo
//
//  Created by Silence on 2019/4/20.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "RoundRectPresentationController.h"

@interface RoundRectPresentationController ()

@property (nonatomic, readonly) UIView *dimmingView;

@end

@implementation RoundRectPresentationController

- (UIView *)dimmingView {
    static UIView *instance = nil;
    if (instance == nil) {
        instance = [[UIView alloc] initWithFrame:self.containerView.bounds];
        instance.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [instance addGestureRecognizer:tap];
    }
    return instance;
}

- (void)presentationTransitionWillBegin {
    UIView *presentedView = self.presentedViewController.view;
    presentedView.layer.cornerRadius = 20.f;
    presentedView.layer.shadowColor = [[UIColor blackColor] CGColor];
    presentedView.layer.shadowOffset = CGSizeMake(0, 10);
    presentedView.layer.shadowRadius = 10;
    presentedView.layer.shadowOpacity = 0.5;
    
    self.dimmingView.frame = self.containerView.bounds;
    self.dimmingView.alpha = 0;
    [self.containerView addSubview:self.dimmingView];
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 1;
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGFloat size = 280;
    CGRect frame = CGRectMake((self.containerView.frame.size.width - size) / 2,
                              (self.containerView.frame.size.height - size) / 2,
                              size, size);
    return frame;
}

- (void)containerViewWillLayoutSubviews {
    self.dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];
}

- (void)onClick:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.dimmingView];
    if (!CGRectContainsPoint([self frameOfPresentedViewInContainerView], point)) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


@end

@implementation BounceAnimationController

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIView *presentedView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    
    presentedView.frame = containerView.bounds;
    [containerView addSubview:presentedView];
    
    CGAffineTransform transform = presentedView.transform;
    presentedView.transform = CGAffineTransformTranslate(transform, 0, -containerView.bounds.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:10
                        options:0
                     animations:^{
                         presentedView.transform = transform;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end
