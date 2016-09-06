//
//  RightViewController.m
//  SpreadDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "RightViewController.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor] ;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 100, 200, 100)];
    label.text = @"右边侧滑栏" ;
    label.font = [UIFont systemFontOfSize:22] ;
    label.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:label] ;
}



@end
