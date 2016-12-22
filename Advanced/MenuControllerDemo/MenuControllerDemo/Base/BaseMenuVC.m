//
//  BaseMenuVC.m
//  MenuControllerDemo
//
//  Created by 杨晴贺 on 22/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "BaseMenuVC.h"
#import "MenuLabel.h"

@interface BaseMenuVC ()

@property (weak, nonatomic) IBOutlet MenuLabel *menuLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BaseMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.v2ex.com"]]] ;
    
    self.menuLabel.text = @"测试Label控件" ;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES] ;
}

@end
