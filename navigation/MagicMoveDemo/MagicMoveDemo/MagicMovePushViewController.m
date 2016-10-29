//
//  MagicMovePushViewController.m
//  MagicMoveDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MagicMovePushViewController.h"
#import "InteractiveTransition.h"
#import "NaviTransition.h"

@interface MagicMovePushViewController ()

@property (nonatomic,strong) InteractiveTransition *interactiveTransition;

@end

@implementation MagicMovePushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"神奇移动效果" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    UIImageView *imageView = [[UIImageView alloc]init] ;
    self.imageView = imageView ;
    [self.view addSubview:imageView] ;
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - self.view.frame.size.height / 2 + 210);
    imageView.bounds = CGRectMake(0, 0, 320, 280);
    UITextView *textView = [UITextView new];
    textView.text = @"这是类似于KeyNote的神奇移动效果，向右滑动可以通过手势控制POP动画";
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    textView.frame = CGRectMake(20, 400, 300, 50) ;
    // 初始化手势动作的代理
    self.interactiveTransition = [InteractiveTransition interactiveTransitionWithTransitionType:InteractiveTransitionTypePop GestureDirection:InteractiveTransitionGestureDirectionRight];
    // 给当前控制器添加手势
    [_interactiveTransition addPanGestureForViewController:self];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    // 分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [NaviTransition transitionWithType:operation == UINavigationControllerOperationPush ? NaviTransitionTypePush : NaviTransitionTypePop];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    // 手势开始的时候才需要传入手势过渡代理，如果直接点击pop，应该传入空，否者无法通过点击正常pop
    return _interactiveTransition.interation ? _interactiveTransition : nil;
}



@end
