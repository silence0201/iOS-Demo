//
//  ViewController.m
//  maskViewDemo
//
//  Created by 杨晴贺 on 8/22/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "MaskView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MaskView *maskView = [[MaskView alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    [maskView showInView:self.view] ;
}
@end
