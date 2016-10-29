//
//  SwipeUpInteractiveTransition.m
//  ModelTransitionDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SwipeUpInteractiveTransition.h"

@interface SwipeUpInteractiveTransition ()

@property (nonatomic,assign) BOOL sholdComplete ;
@property (nonatomic,strong) UIViewController *presentingVc ;

@end

@implementation SwipeUpInteractiveTransition

- (void)writeToViewController:(UIViewController *)Vc{
    self.presentingVc = Vc ;
    [self prepareGestureRecognizerInView:Vc.view] ;
}

- (void)prepareGestureRecognizerInView:(UIView *)view{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)] ;
    [view addGestureRecognizer:gesture] ;
}

- (CGFloat)completionSpeed{
    return self.percentComplete ;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview] ;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.interacting = YES;
            [self.presentingVc dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = translation.y / 400.0;
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.sholdComplete = (fraction > 0.5);
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.interacting = NO;
            if (!self.sholdComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
