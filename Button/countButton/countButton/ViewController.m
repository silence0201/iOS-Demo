//
//  ViewController.m
//  countButton
//
//  Created by 杨晴贺 on 8/30/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "CountButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CountButton *countBtn = [[CountButton alloc]initWithFrame:CGRectMake(100, 100, 150, 60)] ;
    
    countBtn.clickButtonAction = ^{
        NSLog(@"开始获取验证码") ;
    } ;
    
    countBtn.second = 60 ;
    [countBtn setBackgroundImage:[UIImage imageNamed:@"倒计时bg"] forState:UIControlStateNormal] ;
    [countBtn setBackgroundImage:[UIImage imageNamed:@"倒计时bg-pre"] forState:UIControlStateSelected] ;
    [self.view addSubview:countBtn] ;
}


@end
