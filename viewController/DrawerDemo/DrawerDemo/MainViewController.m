//
//  MainViewController.m
//  DrawerDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MainViewController.h"
#import "UIViewController+ConfigureBarButton.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页面" ;
    [self.navigationController.navigationBar setBarTintColor:[UIColor cyanColor]] ;
    [self configureLeftBarButtonWithTitle:@"左侧" action:^{
        NSLog(@"左侧按钮被点击") ;
        [ShareApp.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil] ;
    }] ;
    
    [self configureRightBarButtonWithTitle:@"右侧" action:^{
        NSLog(@"右侧按钮被点击") ;
        [ShareApp.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil] ;
    }] ;
    
    [self setupUI] ;
}

- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    [self.view addSubview:imageView] ;
    imageView.image = [UIImage imageNamed:@"1"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd] ;
    [self.view addSubview:button] ;
    [button addTarget:self action:@selector(btnClickAction) forControlEvents:UIControlEventTouchUpInside] ;
    button.center = self.view.center  ;
}

- (void)btnClickAction{
    NSLog(@"%s",__func__) ;
    [self.navigationController pushViewController:[DetailViewController new] animated:YES] ;
}


@end
