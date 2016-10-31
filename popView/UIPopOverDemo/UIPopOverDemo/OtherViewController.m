//
//  OtherViewController.m
//  UIPopOverDemo
//
//  Created by 杨晴贺 on 31/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 200)] ;
    imageView.image = [UIImage imageNamed:@"11"] ;
    imageView.contentMode  = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
}


@end
