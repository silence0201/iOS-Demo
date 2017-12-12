//
//  ViewController.m
//  TableViewMoveDemo
//
//  Created by Silence on 2017/12/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "SystemMoveViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)systemTableMove:(id)sender {
    [self.navigationController pushViewController:[SystemMoveViewController new] animated:YES];
}

@end
