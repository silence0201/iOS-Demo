//
//  ViewController.m
//  ModelTransitionDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
#import "OtherViewController.h"
#import "SwipeUpInteractiveTransition.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) BouncePresentAnimation *presentAnimation ;
@property (nonatomic,strong) NormalDismissAnimation *dismissAnimation ;
@property (nonatomic,strong) SwipeUpInteractiveTransition *interactiveTransition ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imageView = [[UIImageView alloc]init] ;
    imageView.frame = [UIScreen mainScreen].bounds ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    imageView.image = [UIImage imageNamed:@"1"] ;
    [self.view addSubview:imageView] ;
    [self.view sendSubviewToBack:imageView] ;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)] ;
    [button setTintColor:[UIColor redColor]] ;
    [button setTitle:@"跳转" forState:UIControlStateNormal] ;
    [button addTarget:self action:@selector(persentAction:) forControlEvents:UIControlEventTouchUpInside] ;
    button.center = self.view.center ;
    [self.view addSubview:button] ;
}
- (void)persentAction:(id)sender {
    OtherViewController *vc = [OtherViewController new] ;
    vc.transitioningDelegate = self ;
    [self.interactiveTransition writeToViewController:vc] ;
    [self presentViewController:vc animated:YES completion:nil] ;
}

- (BouncePresentAnimation *)presentAnimation{
    if (!_presentAnimation) {
        _presentAnimation = [[BouncePresentAnimation alloc]init] ;
    }
    return _presentAnimation ;
}

- (SwipeUpInteractiveTransition *)interactiveTransition{
    if (!_interactiveTransition) {
        _interactiveTransition = [[SwipeUpInteractiveTransition alloc]init] ;
    }
    return _interactiveTransition ;
}


- (NormalDismissAnimation *)dismissAnimation{
    if(!_dismissAnimation){
        _dismissAnimation = [[NormalDismissAnimation alloc]init] ;
    }
    return _dismissAnimation ;
}

#pragma mark -- UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.presentAnimation ;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.dismissAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveTransition.interacting?self.interactiveTransition : nil ;
}



@end
