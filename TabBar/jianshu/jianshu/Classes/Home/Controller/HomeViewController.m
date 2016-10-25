//
//  HomeViewController.m
//  jianshu
//
//  Created by 杨晴贺 on 25/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "HomeViewController.h"
#import "TestViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor] ;
    self.title = @"发现" ;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem] ;
    [button setTitle:@"首页测试" forState:UIControlStateNormal] ;
    button.titleLabel.font = [UIFont systemFontOfSize:18] ;
    button.frame = CGRectMake(0, 0, 200, 40) ;
    button.center = self.view.center ;
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside] ;
}

- (void)clickButton{
    [self.navigationController pushViewController:[TestViewController new] animated:YES] ;
}

@end
