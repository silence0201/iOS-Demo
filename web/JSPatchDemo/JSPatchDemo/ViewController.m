//
//  ViewController.m
//  JSPatchDemo
//
//  Created by 杨晴贺 on 03/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Table" style:UIBarButtonItemStylePlain target:self action:@selector(handleBtn:)] ;
}

- (void)handleBtn:(UIButton *)button{
    NSLog(@"%s",__func__) ;
}



@end
