//
//  PresentViewController.m
//  PresentOneControllerDemo
//
//  Created by 杨晴贺 on 05/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "PresentViewController.h"
#import "Masonry.h"
#import "InteractiveTransition.h"
#import "PresentOneTransition.h"
#import "ViewController.h"

@interface PresentViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) InteractiveTransition *interactiveDismiss ;

@end

@implementation PresentViewController

- (instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self ;
        self.modalPresentationStyle = UIModalPresentationCustom ;
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 5 ;
    self.view.clipsToBounds = YES ;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = [UIImage imageNamed:@"3"] ;
    imageView.contentMode = UIViewContentModeScaleToFill ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    [self.view addSubview:imageView] ;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view) ;
        make.height.mas_equalTo(450) ;
        make.top.right.left.equalTo(self.view) ;
    } ] ;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50) ];
    [self.view addSubview:button] ;
    [button setTitle:@"返回" forState:UIControlStateNormal] ;
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside] ;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageView).mas_offset(-100) ;
        make.centerX.equalTo(self.view) ;
        make.width.mas_equalTo(100) ;
    }] ;
    
    self.interactiveDismiss = [InteractiveTransition interactiveTransitionWithTransitionType:InteractiveTransitionTypeDismiss GestureDirection:InteractiveTransitionGestureDirectionDown] ;
    [self.interactiveDismiss addPanGestureForViewController:self] ;
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveDismiss.interation ? _interactiveDismiss : nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [PresentOneTransition transitionWithTransitionType:PresentOneTransitionStylePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [PresentOneTransition transitionWithTransitionType:PresentOneTransitionStyleDismiss];
}

@end
