//
//  WKWebViewDemo.m
//  WebViewJavascriptBridgeDemo
//
//  Created by 杨晴贺 on 04/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <AVFoundation/AVFoundation.h>
#import "WKWebViewDemo.h"
#import "WKWebViewJavascriptBridge.h"

@interface WKWebViewDemo ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView *webView ;
@property (nonatomic,strong) WKWebViewJavascriptBridge *webViewBridge ;

@end

@implementation WKWebViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self initWebView] ;
    
    _webViewBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [_webViewBridge setWebViewDelegate:self];
    
    [self registerMethod] ;
}

- (void)initWebView{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 30.0;
    configuration.preferences = preferences;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"Demo.html" ofType:nil];
    NSString *localHtml = [NSString stringWithContentsOfFile:urlStr encoding:NSUTF8StringEncoding error:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    [self.webView loadHTMLString:localHtml baseURL:fileURL];
    
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
}

- (void)rightClick{
    // 如果不需要参数，不需要回调，使用这个
    // [_webViewBridge callHandler:@"testJSFunction"];
    // 如果需要参数，不需要回调，使用这个
    // [_webViewBridge callHandler:@"testJSFunction" data:@"Test Data"];
    // 如果既需要参数，又需要回调，使用这个
    [_webViewBridge callHandler:@"testJSFunction" data:@"Test Data" responseCallback:^(id responseData) {
        NSLog(@"调用完JS后的回调：%@",responseData);
    }];
}

- (void)registerMethod{
    [_webViewBridge registerHandler:@"locationClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *location = @"浙江省杭州市";
        // 将结果返回给js
        responseCallback(location);
    }];

    // 注册的handler 是供 JS调用Native 使用的。
    [_webViewBridge registerHandler:@"scanClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"扫一扫");
        NSString *scanResult = @"扫描结果为:http://www.baidu.com";
        responseCallback(scanResult);
    }];

    [_webViewBridge registerHandler:@"shareClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *shareDic = data;
        // 在这里执行分享的操作
        NSString *title = [shareDic objectForKey:@"title"];
        NSString *content = [shareDic objectForKey:@"content"];
        NSString *url = [shareDic objectForKey:@"url"];
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"分享成功:%@,%@,%@",title,content,url];
        responseCallback(result);
    }];

    __weak typeof(self) weakSelf = self;
    [_webViewBridge registerHandler:@"colorClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *colorDic = data;
        
        CGFloat r = [[colorDic objectForKey:@"r"] floatValue];
        CGFloat g = [[colorDic objectForKey:@"g"] floatValue];
        CGFloat b = [[colorDic objectForKey:@"b"] floatValue];
        CGFloat a = [[colorDic objectForKey:@"a"] floatValue];
        
        weakSelf.webView.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
    }];

    [_webViewBridge registerHandler:@"payClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *payDic = data;
        NSString *orderNo = [payDic objectForKey:@"order_no"];
        NSString *subject = [payDic objectForKey:@"subject"];
        NSString *channel = [payDic objectForKey:@"channel"];
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"支付成功:%@,%@,%@",orderNo,subject,channel];
        responseCallback(result);
    }];
    
    [_webViewBridge registerHandler:@"shakeClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    }];
    [_webViewBridge registerHandler:@"goback" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf.navigationController popViewControllerAnimated:YES] ;
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
