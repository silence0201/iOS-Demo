//
//  ViewController.m
//  JavaScriptCoreDemo
//
//  Created by 杨晴贺 on 23/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "JSCallOCViewController.h"
#import "OCCallJSViewController.h"
#import "HighcharsWebView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"菜单" ;
}

- (IBAction)jsCallOC:(id)sender {
    JSCallOCViewController *jc = [[JSCallOCViewController alloc]init] ;
    [self.navigationController pushViewController:jc animated:YES] ;
}

- (IBAction)ocCallJS:(id)sender {
    OCCallJSViewController *cj = [[OCCallJSViewController alloc]init] ;
    [self.navigationController pushViewController:cj animated:YES] ;
}

- (IBAction)highchartsWeb:(id)sender {
    HighcharsWebView *highcharsWebView = [[HighcharsWebView alloc]init] ;
    [self.navigationController pushViewController:highcharsWebView animated:YES] ;
}



@end
