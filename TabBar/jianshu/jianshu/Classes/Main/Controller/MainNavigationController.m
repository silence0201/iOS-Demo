//
//  MainNavigationController.m
//  jianshu
//
//  Created by 杨晴贺 on 25/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()<UINavigationControllerDelegate>

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self ;
}

- (UIBarButtonItem *)barButtonItemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 40, 40);
    button.imageView.contentMode = UIViewContentModeLeft;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    button.adjustsImageWhenHighlighted = NO;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *popToPreButton = [self barButtonItemWithImage:@"SVWebViewControllerBack" highImage:nil target:self action:@selector(popToPre)];
        viewController.navigationItem.leftBarButtonItem = popToPreButton;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)popToPre{
    [self popViewControllerAnimated:YES];
}

#pragma mark --------navigation delegate
//该方法可以解决popRootViewController时tabbar的bug
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //删除系统自带的tabBarButton
    for (UIView *tabBar in self.tabBarController.tabBar.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBar removeFromSuperview];
        }
    }
}

@end
