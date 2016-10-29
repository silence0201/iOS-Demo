//
//  PushViewController.m
//  NavigationTransitionAnimationDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]init] ;
    imageView.frame = [UIScreen mainScreen].bounds ;
    imageView.image = [UIImage imageNamed:@"2"] ;
    imageView.contentMode  = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)] ;
    [button setTitle:@"Pop" forState:UIControlStateNormal] ;
    button.center  = self.view.center ;
    [button addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:button] ;
    
    self.title = @"Push" ;
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES] ;
}


@end
