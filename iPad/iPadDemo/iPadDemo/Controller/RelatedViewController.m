//
//  RelatedViewController.m
//  iPadDemo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "RelatedViewController.h"

@interface RelatedViewController ()

@property (nonatomic,strong) UIImageView *imageView ;

@end

@implementation RelatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"与我相关" ;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = [UIImage imageNamed:@"4"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    _imageView = imageView ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil] ;
}

- (void)orientationDidChange:(NSNotification *)noti{
    self.imageView.size = self.view.size ;
}

@end
