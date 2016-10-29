//
//  InteractionTransitionAnimation.m
//  NavigationTransitionAnimationDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "InteractionTransitionAnimation.h"

@interface InteractionTransitionAnimation ()

@property (nonatomic,assign) BOOL canReceice ;
@property (nonatomic,strong) UIViewController *vc ;

@end

@implementation InteractionTransitionAnimation

- (void)writeToViewController:(UIViewController *)toVc{
    self.vc = toVc ;
    [self addPanGesture:toVc.view] ;
}

- (void)addPanGesture:(UIView *)view{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognizer:)] ;
    [view addGestureRecognizer:pan] ;
}

- (void)panRecognizer:(UIPanGestureRecognizer *)pan{
    CGPoint panPoint = [pan translationInView:pan.view.superview] ;
    CGPoint locationPoint = [pan locationInView:pan.view.superview] ;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.isActing = YES;
        if (locationPoint.y <= self.vc.view.bounds.size.height/2.0) {
            [self.vc.navigationController popViewControllerAnimated:YES];
        }
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
        if (locationPoint.y >= self.vc.view.bounds.size.height/2.0) {
            self.canReceice = YES;
        }else{
            self.canReceice = NO;
        }
        
        [self updateInteractiveTransition:panPoint.y/self.vc.view.bounds.size.height];
        
    }else if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded){
        self.isActing = NO;
        if(!self.canReceice || pan.state == UIGestureRecognizerStateCancelled)
        {
            [self cancelInteractiveTransition];
        }else{
            [self finishInteractiveTransition];
        }
    }
}


@end
