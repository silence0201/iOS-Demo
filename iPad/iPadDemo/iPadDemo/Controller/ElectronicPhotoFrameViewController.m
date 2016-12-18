//
//  ElectronicPhotoFrameViewController.m
//  iPadDemo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ElectronicPhotoFrameViewController.h"

@interface ElectronicPhotoFrameViewController ()
@property (nonatomic,strong) UIImageView *imageView ;
@end

@implementation ElectronicPhotoFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电子相框" ;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = [UIImage imageNamed:@"6"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    _imageView = imageView ;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil] ;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews] ;
    self.imageView.size = self.view.size ;
}

- (void)orientationDidChange:(NSNotification *)noti{
    self.imageView.size = self.view.size ;
}


@end
