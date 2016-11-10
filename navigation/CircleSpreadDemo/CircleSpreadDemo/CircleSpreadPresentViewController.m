//
//  CircleSpreadPresentViewController.m
//  CircleSpreadDemo
//
//  Created by 杨晴贺 on 10/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CircleSpreadPresentViewController.h"
#import "InteractiveTransition.h"
#import "CircleSpreadTransition.h"
#import "Masonry.h"

@interface CircleSpreadPresentViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) InteractiveTransition *interactiveTransition ;

@end

@implementation CircleSpreadPresentViewController

- (instancetype)init{
    if(self = [super init]){
        self.transitioningDelegate = self ;
        self.modalPresentationStyle = UIModalPresentationCustom ;
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"3"]] ;
    [self.view addSubview:imageView] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view) ;
    }] ;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 50, self.view.frame.size.width, 50);
    [self.view addSubview:button];
    
    self.interactiveTransition = [InteractiveTransition interactiveTransitionWithTransitionType:InteractiveTransitionTypeDismiss GestureDirection:InteractiveTransitionGestureDirectionDown];
    [self.interactiveTransition addPanGestureForViewController:self];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [CircleSpreadTransition transitionWithTransitionType:CircleSpreadTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [CircleSpreadTransition transitionWithTransitionType:CircleSpreadTransitionTypeDismiss];
}



- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveTransition.interation ? _interactiveTransition : nil;
}


@end
