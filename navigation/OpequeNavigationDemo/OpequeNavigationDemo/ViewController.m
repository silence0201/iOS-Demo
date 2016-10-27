//
//  ViewController.m
//  OpequeNavigationDemo
//
//  Created by 杨晴贺 on 27/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>{
    UIImageView *_barImageView ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds] ;
    
    scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0) ;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height*2) ;
    scrollView.showsVerticalScrollIndicator = NO ;
    scrollView.showsHorizontalScrollIndicator = NO ;
    scrollView.delegate = self ;
    
    UIImageView *imageView = [[UIImageView alloc]init] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width*2, self.view.frame.size.height*2) ;
    imageView.image = [UIImage imageNamed:@"3"] ;
    [scrollView addSubview:imageView] ;
    
    
    [self.view addSubview:scrollView] ;
    
    // 设置导航栏透明
    [self.navigationController.navigationBar setShadowImage:[UIImage new]] ;
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault] ;
    
    // 渐变透明
    _barImageView = self.navigationController.navigationBar.subviews.firstObject ;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat minAlphaOffset = - 64;
    CGFloat maxAlphaOffset = 200;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    _barImageView.alpha = alpha;
}


@end
