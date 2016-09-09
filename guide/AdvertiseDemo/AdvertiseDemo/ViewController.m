//
//  ViewController.m
//  AdvertiseDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "AdvertiseViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页" ;
    self.view.backgroundColor = [UIColor lightGrayColor] ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];
}

- (void)pushToAd{
    AdvertiseViewController *adVc = [[AdvertiseViewController alloc]init] ;
    [self.navigationController pushViewController:adVc animated:YES] ;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self] ;
}

@end
