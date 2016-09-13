//
//  ViewController.m
//  FrostedGlassDemo
//
//  Created by 杨晴贺 on 9/13/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>
#define SCREEN_WIDTH   ([[UIScreen mainScreen] bounds].size.width) // 屏幕宽度
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)// 屏幕高度


@interface ViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic,strong) UILabel *label ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)] ;
    imageView.image = [UIImage imageNamed:@"pic"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    
    // blur效果
    UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]] ;
    visualEfView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 2) ;
    visualEfView.alpha = 0.6 ;
    [imageView addSubview:visualEfView] ;
    
    // 文本
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 3, SCREEN_WIDTH, 50) ] ;
    titleLabel.text = @"欢迎访问我的Github:silence0201" ;
    titleLabel.textColor = [UIColor blackColor] ;
    titleLabel.textAlignment = NSTextAlignmentCenter ;
    titleLabel.font = [UIFont systemFontOfSize:20] ;
    [self.view addSubview:titleLabel] ;
    
    // 注册3DTouch
    [self registerForPreviewingWithDelegate:self sourceView:self.view] ;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent ;
}

#pragma mark - UIViewControllerPreviewingDelegate
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    // 固定写法
    [self showViewController:viewControllerToCommit sender:self] ;
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    // location为重压点坐标
    CGPoint point = [self.label.layer convertPoint:location fromLayer:self.view.layer] ;
    if ([self.label.layer containsPoint:point]) {
        SFSafariViewController *sv = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://github.com/silence0201"]] ;
        sv.preferredContentSize = CGSizeMake(0, 400) ;
        previewingContext.sourceRect = self.label.frame;//设置高亮区域
        return sv ;
    }
    return nil ;
}

@end
