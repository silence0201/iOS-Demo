//
//  SystemMoveViewController.m
//  TableViewMoveDemo
//
//  Created by Silence on 2017/12/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SystemMoveViewController.h"

@interface SystemMoveViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,copy) NSArray *dataSource;

@end

@implementation SystemMoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统移动Demo";
    
    self.dataSource = @[@"Silence0",@"Silence1",@"Silence2",@"Silence3",@"Silence4",@"Silence5"];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 34)];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = barItem;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 44 ;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idCell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCell];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)clickEdit:(UIButton *)btn {
    btn.selected = !btn.isSelected;
    [self.tableView setEditing:btn.isSelected animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSMutableArray *arr = [self.dataSource mutableCopy] ;
    [arr exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    self.dataSource = arr;
}


@end
