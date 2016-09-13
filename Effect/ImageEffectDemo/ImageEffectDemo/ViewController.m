//
//  ViewController.m
//  ImageEffectDemo
//
//  Created by 杨晴贺 on 9/13/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageEffects.h"
#import "ObjectFunction.h"
#define SCREEN_WIDTH   ([[UIScreen mainScreen] bounds].size.width) // 屏幕宽度
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)// 屏幕高度

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    imageView.image = [[UIImage imageNamed:@"image"] applyDarkEffect] ;
//    imageView.image = [ObjectFunction blurryImage:[UIImage imageNamed:@"image"] withBlurLevel:20.0f];
    [self.view addSubview:imageView] ;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent ;
}


@end
