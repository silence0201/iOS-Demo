//
//  ViewController.m
//  WebViewCookieDemo
//
//  Created by Silence on 2018/5/8.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ViewController.h"

#define DemoURL @"http://www.playcode.cc"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取沙盒中是否包含cookie
    [self loadSavedCookies];
    
    // 发送请求
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",DemoURL]]];
    [ self.webView loadRequest:req];
}

#pragma mark -- UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 获取的cookie储存在沙盒中
    [self saveCookies];
}

- (void)saveCookies{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: cookies];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey:@"silence.cookie"];
    [defaults synchronize];
}
//合适的时机加载持久化后Cookie 一般都是app刚刚启动的时候
- (void)loadSavedCookies{
    if ([[[[NSUserDefaults standardUserDefaults]dictionaryRepresentation]allKeys]containsObject:@"silence.cookie"])  {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"silence.cookie"]];
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in cookies){
            NSLog(@"name:%@,value:%@",cookie.name,cookie.value);
            [cookieStorage setCookie:cookie];
        }
    }
}


@end
