//
//  BlogViewController.m
//  iPadDemo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "BlogViewController.h"

@interface BlogViewController ()

@end

@implementation BlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = [UIImage imageNamed:@"3"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.title = @"博客";
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

@end
