//
//  ModelViewController.m
//  iPadDemo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ModelViewController.h"

@interface ModelViewController ()

@end

@implementation ModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = [UIImage imageNamed:@"2"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.title = @"发表心情";
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, 100, 44)] ;
    label.text = @"测试文本" ;
    label.font = [UIFont systemFontOfSize:18.0f] ;
    [self.view addSubview:label] ;
    
    NSLog(@"%@",self.view) ;
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

@end
