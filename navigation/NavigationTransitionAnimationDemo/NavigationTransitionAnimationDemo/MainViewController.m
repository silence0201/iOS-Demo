//
//  MainViewController.m
//  NavigationTransitionAnimationDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MainViewController.h"
#import "PushTransition.h"
#import "PopTransition.h"
#import "PushViewController.h"
#import "InteractionTransitionAnimation.h"

@interface MainViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) PushTransition *pushTransition ;
@property (nonatomic,strong) PopTransition *popTransition ;
@property (nonatomic,strong) InteractionTransitionAnimation *interactionTransitionAnimation ;

@end

@implementation MainViewController

#pragma mark -- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]init] ;
    imageView.frame = [UIScreen mainScreen].bounds ;
    imageView.image = [UIImage imageNamed:@"1"] ;
    imageView.contentMode  = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)] ;
    [button setTitle:@"Push" forState:UIControlStateNormal] ;
    button.center  = self.view.center ;
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:button] ;
    
    self.navigationController.delegate = self ;
    
    self.title = @"Main" ;
}
#pragma mark -- Lazy Load
- (PushTransition *)pushTransition{
    if (!_pushTransition) {
        _pushTransition = [[PushTransition alloc]init] ;
    }
    return _pushTransition ;
}

- (PopTransition *)popTransition{
    if(!_popTransition){
        _popTransition = [[PopTransition alloc]init] ;
    }
    return _popTransition ;
}

- (InteractionTransitionAnimation *)interactionTransitionAnimation{
    if (!_interactionTransitionAnimation) {
        _interactionTransitionAnimation = [[InteractionTransitionAnimation alloc]init] ;
    }
    return _interactionTransitionAnimation ;
}

#pragma mark -- Action
- (void)push{
    PushViewController *vc = [[PushViewController alloc]init] ;
    [self.interactionTransitionAnimation writeToViewController:vc] ;
    [self.navigationController pushViewController:vc animated:YES] ;
}

#pragma mark -- Navgation Delegate
/** 返回转场动画实例*/
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return self.pushTransition;
    }else if (operation == UINavigationControllerOperationPop){
        return self.popTransition;
    }
    return nil;
}

/** 返回交互手势实例*/
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                        interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.interactionTransitionAnimation.isActing ? self.interactionTransitionAnimation : nil;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"willShowViewController - %@",self.interactionTransitionAnimation.isActing ?@"YES":@"NO");
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"didShowViewController - %@",self.interactionTransitionAnimation.isActing ?@"YES":@"NO");
}


@end
