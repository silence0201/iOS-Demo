//
//  RedViewController.m
//  SpreadDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "RedViewController.h"

@interface RedViewController ()

@end

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView] ;
}

- (void)initView{
    [super initView] ;
    self.view.backgroundColor = [UIColor redColor] ;
}

- (NSString *)controllerTitle{
    return @"红色控制器" ;
}

@end
