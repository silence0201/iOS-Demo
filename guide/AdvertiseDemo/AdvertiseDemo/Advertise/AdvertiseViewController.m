//
//  AdvertiseViewController.m
//  AdvertiseDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AdvertiseViewController.h"

@interface AdvertiseViewController ()

@property (nonatomic,strong) UIWebView *webView ;
@end

@implementation AdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"点击进入的广告页面" ;
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds] ;
    _webView.backgroundColor = [UIColor whiteColor] ;
    if (!self.advertiseUrl) {
        // 设置默认页面
        self.advertiseUrl = @"https://www.baidu.com" ;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.advertiseUrl]] ;
    [_webView loadRequest:request] ;
    [self.view addSubview:_webView] ;
    
}



@end
