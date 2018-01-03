//
//  ViewController.m
//  SkeletonViewDemo
//
//  Created by Silence on 2018/1/3.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet TestView *testView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"骨架View测试";
    self.testView.backgroundColor = [UIColor redColor];
    [self.testView beginSkeleton];
}



@end
