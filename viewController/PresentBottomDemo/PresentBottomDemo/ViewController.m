//
//  ViewController.m
//  PresentBottomDemo
//
//  Created by Silence on 2019/4/20.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "RoundRectPresentationController.h"
#import "DemoViewController.h"
#import "BottomPresentationController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)clickBtn:(id)sender {
    DemoViewController *vc = [DemoViewController new];
//    vc.modalTransitionStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    return [[BounceAnimationController alloc] init];
//}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
//    return [[RoundRectPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    BottomPresentationController *vc = [[BottomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    vc.controllerHeight = 300;
    return vc;
    
}


@end
