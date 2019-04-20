//
//  BottomPresentationController.m
//  PresentBottomDemo
//
//  Created by Silence on 2019/4/20.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "BottomPresentationController.h"

static CGFloat controllerHeight = 500;

@interface BottomPresentationController ()
@property (strong, nonatomic) UIView *blackView;
@end

@implementation BottomPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        _controllerHeight = 500 ;
    }
    return self;
}

- (void)presentationTransitionWillBegin {
    [super presentationTransitionWillBegin];
    self.blackView.alpha = 0;
    [self.containerView addSubview:self.blackView];
    [UIView animateWithDuration:1.0 animations:^{
        self.blackView.alpha = 1;
    }];
}

- (void)dismissalTransitionWillBegin {
    [super dismissalTransitionWillBegin];
    [UIView animateWithDuration:1.0 animations:^{
        self.blackView.alpha = 0;
    }];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    [super dismissalTransitionDidEnd:completed];
    if (completed) {
        [self.blackView removeFromSuperview];
    }
}


- (CGRect)frameOfPresentedViewInContainerView {
    return CGRectMake(0, [UIScreen mainScreen].bounds.size.height-_controllerHeight, [UIScreen mainScreen].bounds.size.width, _controllerHeight);
}

- (void)onClick:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.blackView];
    if (!CGRectContainsPoint([self frameOfPresentedViewInContainerView], point)) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}



- (UIView *)blackView {
    if (_blackView == nil) {
        _blackView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        _blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_blackView addGestureRecognizer:tap];
    }
    return _blackView;
}

@end
