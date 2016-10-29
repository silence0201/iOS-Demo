//
//  OtherViewController.m
//  ModelTransitionDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]init] ;
    imageView.frame = [UIScreen mainScreen].bounds ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    imageView.image = [UIImage imageNamed:@"2"] ;
    [self.view addSubview:imageView] ;
    [self.view sendSubviewToBack:imageView] ;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)]  ;
    [button setTintColor:[UIColor redColor]] ;
    [button setTitle:@"退出" forState:UIControlStateNormal] ;
    [button addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside] ;
    button.center = self.view.center ;
    [self.view addSubview:button] ;
}

- (void)dismissAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

@end
