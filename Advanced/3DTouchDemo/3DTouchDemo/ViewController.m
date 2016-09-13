//
//  ViewController.m
//  3DTouchDemo
//
//  Created by 杨晴贺 on 9/13/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic,strong) UILabel *gitHubLabel ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _gitHubLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 40) ];
    _gitHubLabel.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2) ;
    _gitHubLabel.text = @"我的GitHub" ;
    self.title = @"主页" ;
    [self.view addSubview:_gitHubLabel] ;
    
    //注册代理
    [self registerForPreviewingWithDelegate:self sourceView:self.view] ;
}

#pragma mark - UIViewControllerPreviewingDelegate
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    // 固定写法
    [self showViewController:viewControllerToCommit sender:self] ;
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    // location为重压的坐标
    CGPoint point = [self.gitHubLabel.layer convertPoint:location fromLayer:self.view.layer] ;
    if ([self.gitHubLabel.layer containsPoint:point]) {
        SFSafariViewController *sv = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://github.com/silence0201"]] ;
        sv.preferredContentSize = CGSizeMake(0, 400) ;
        previewingContext.sourceRect = self.gitHubLabel.frame;//设置高亮区域
        return sv ;
    }
    return nil ;
}


@end
