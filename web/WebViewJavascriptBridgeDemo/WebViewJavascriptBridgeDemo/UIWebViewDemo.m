//
//  UIWebViewDemo.m
//  WebViewJavascriptBridgeDemo
//
//  Created by 杨晴贺 on 04/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "UIWebViewDemo.h"
#import "WebViewJavascriptBridge.h"

@interface UIWebViewDemo ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView ;

@property (nonatomic,strong) WebViewJavascriptBridge *webViewBridge ;

@end

@implementation UIWebViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIWebViewDemo" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightClick)] ;
    self.navigationItem.rightBarButtonItem = rightItem ;
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds] ;
    [self.view addSubview:self.webView] ;
    
    NSURL *htmlURL = [[NSBundle mainBundle]URLForResource:@"Demo" withExtension:@"html"] ;
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL] ;
    
    // self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal ;
    [self.webView loadRequest:request] ;
    
    self.webViewBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView] ;
    [self.webViewBridge setWebViewDelegate:self] ;
    
    [self registerMethod] ;
}

/// OC调用JS注册方法简单Demo
- (void)rightClick{
    
    // 无参数,无回调
    // [self.webViewBridge callHandler:@"test"] ;
    
    // 无回调
    // [self.webViewBridge callHandler:@"test" data:@"testData"] ;

    [self.webViewBridge callHandler:@"testJSFunction" data:@"Test Data" responseCallback:^(id responseData) {
        NSLog(@"调用玩JS后的回调:%@",responseData) ;
    }] ;
}

/// 注册需要让JS调用的方法
- (void)registerMethod{
    // 注册handler,提供给JS调用
    [self.webViewBridge registerHandler:@"scanClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"扫一扫") ;
        NSString *scanResult = @"扫一扫的结果:http://www.baidu.com" ;
        // 传给JS进行回调
        responseCallback(scanResult) ;
    }] ;
    
    [self.webViewBridge registerHandler:@"locationClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 获取位置信息
        NSString *location = @"定位地址:浙江省杭州市" ;
        // 将结果传个给S
        responseCallback(location) ;
    }] ;
    
    __weak typeof (self) weakSelf = self ;
    [self.webViewBridge registerHandler:@"colorClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *colorDic = data ;
        CGFloat r = [[colorDic objectForKey:@"r"] floatValue];
        CGFloat g = [[colorDic objectForKey:@"g"] floatValue];
        CGFloat b = [[colorDic objectForKey:@"b"] floatValue];
        CGFloat a = [[colorDic objectForKey:@"a"] floatValue];
        weakSelf.webView.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
        // 将改变的颜色信息返回JS
        NSString *colorStr = [NSString stringWithFormat:@"改变颜色:%f,%f,%f",r,g,b] ;
        responseCallback(colorStr) ;
    }] ;
    
    [self.webViewBridge registerHandler:@"shareClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *shareDic = data;
        // 在这里执行分享的操作
        NSString *title = [shareDic objectForKey:@"title"];
        NSString *content = [shareDic objectForKey:@"content"];
        NSString *url = [shareDic objectForKey:@"url"];
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"分享成功:%@,%@,%@",title,content,url];
        responseCallback(result);
    }] ;
    
    [self.webViewBridge registerHandler:@"payClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *payDic = data;
        NSString *orderNo = [payDic objectForKey:@"order_no"];
        NSString *subject = [payDic objectForKey:@"subject"];
        NSString *channel = [payDic objectForKey:@"channel"];
        
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"支付成功:%@,%@,%@",orderNo,subject,channel];
        responseCallback(result);
    }] ;
    
    [self.webViewBridge registerHandler:@"shakeClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
        responseCallback(@"shakeClick") ;
    }];
    
    [self.webViewBridge registerHandler:@"goback" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf.navigationController popViewControllerAnimated:YES] ;
        responseCallback(@"goback") ;
    }];
    
}

@end
