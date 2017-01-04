//
//  ViewController.m
//  WebViewJavascriptBridgeDemo
//
//  Created by 杨晴贺 on 04/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "ViewController.h"
#import "UIWebViewDemo.h"
#import "WKWebViewDemo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)UIWebViewAction:(id)sender {
    UIWebViewDemo *webViewDemo = [[UIWebViewDemo alloc]init] ;
    [self.navigationController pushViewController:webViewDemo animated:YES] ;
}

- (IBAction)WKWebViewAction:(id)sender {
    WKWebViewDemo *webViewDemo = [[WKWebViewDemo alloc]init] ;
    [self.navigationController pushViewController:webViewDemo animated:YES] ;
}


@end
