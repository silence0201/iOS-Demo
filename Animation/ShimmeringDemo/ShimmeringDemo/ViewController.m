//
//  ViewController.m
//  ShimmeringDemo
//
//  Created by Silence on 2017/12/18.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "FBShimmeringView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"background"];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    blurView.frame = imageView.bounds;
    [imageView addSubview:blurView];
    
    [self.view addSubview:imageView];
    
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
    [self.view addSubview:shimmeringView];
    shimmeringView.center = self.view.center;
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.text = @"测试文本测试文本测试文本";
    shimmeringView.contentView = loadingLabel;
    
    // Start shimmering.
    shimmeringView.shimmering = YES;
}


@end
