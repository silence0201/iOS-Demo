//
//  ViewController.m
//  TouchID
//
//  Created by 杨晴贺 on 09/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = [UIImage imageNamed:@"p108"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
}


@end
