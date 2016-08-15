//
//  SecondTableViewController.m
//  SubViewControllerDemo
//
//  Created by 杨晴贺 on 8/15/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SecondTableViewController.h"

@interface SecondTableViewController ()

@end

@implementation SecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor] ;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50) ];
    label.text = @"第二个控制器" ;
    label.center = self.view.center ;
    [self.view addSubview:label] ;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}



@end
