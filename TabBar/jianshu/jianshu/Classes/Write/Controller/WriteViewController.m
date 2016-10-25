//
//  WriteViewController.m
//  jianshu
//
//  Created by 杨晴贺 on 25/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "WriteViewController.h"

@interface WriteViewController ()

@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Write" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    // 设置导航栏的按钮
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton)] ;
     self.navigationItem.leftBarButtonItem = backButton ;
}

- (void)clickLeftButton{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

@end
