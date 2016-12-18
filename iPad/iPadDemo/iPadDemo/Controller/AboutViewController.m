//
//  AboutViewController.m
//  iPadDemo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic,strong) UIImageView *imageView ;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心" ;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = [UIImage imageNamed:@"1"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    _imageView = imageView ;
    [self.view addSubview:imageView] ;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil] ;
}


- (void)orientationDidChange:(NSNotification *)noti{
    // 748  1004
    BOOL isLandspace = self.view.height == kLandscapeHeight - 20  ;
    if (isLandspace) {
        self.imageView.height = kLandscapeHeight - 20 ;
        self.imageView.width = kLandspaceWidth - kDockLandspaceWidth ;
    }else{
        self.imageView.height = kLandspaceWidth - 20 ;
        self.imageView.width = kLandscapeHeight - kDockPortraitWidth ;
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self] ;
}


@end
