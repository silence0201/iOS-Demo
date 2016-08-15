//
//  FifthTableViewController.m
//  SubViewControllerDemo
//
//  Created by 杨晴贺 on 8/15/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "FifthTableViewController.h"

@interface FifthTableViewController ()

@end

@implementation FifthTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor] ;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50) ];
    label.text = @"第五个控制器" ;
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
