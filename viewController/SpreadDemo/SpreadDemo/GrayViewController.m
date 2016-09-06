//
//  GrayViewController.m
//  SpreadDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "GrayViewController.h"

@interface GrayViewController ()

@end

@implementation GrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView] ;
}

- (void)initView{
    [super initView] ;
    self.view.backgroundColor = [UIColor grayColor] ;
}

- (NSString *)controllerTitle{
    return @"灰色控制器" ;
}


@end
