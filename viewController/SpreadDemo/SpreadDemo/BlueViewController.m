//
//  BlueViewController.m
//  SpreadDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView ] ;
}

- (void)initView{
    [super initView] ;
    self.view.backgroundColor = [UIColor blueColor] ;
}

- (NSString *)controllerTitle{
    return @"蓝色控制器" ;
}

@end
