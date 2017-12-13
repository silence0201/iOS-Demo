//
//  MoveableTableViewController.m
//  TableViewMoveDemo
//
//  Created by Silence on 2017/12/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "MoveableTableViewController.h"
#import "MoveableTableView.h"

@interface MoveableTableViewController ()<MovableTableViewDelegate,MovableTableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MoveableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray new];
    for (NSInteger section = 0; section < 6; section ++) {
        NSMutableArray *sectionArray = [NSMutableArray new];
        for (NSInteger row = 0; row < 5; row ++) {
            [sectionArray addObject:[NSString stringWithFormat:@"section -- %ld row -- %ld", section, row]];
        }
        [_dataSource addObject:sectionArray];
    }
    
    MoveableTableView *tableView = [[MoveableTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    tableView.drawMovalbeCellBlock = ^(UIView *movableCell){
        movableCell.layer.shadowColor = [UIColor grayColor].CGColor;
        movableCell.layer.masksToBounds = NO;
        movableCell.layer.cornerRadius = 0;
        movableCell.layer.shadowOffset = CGSizeMake(-5, 0);
        movableCell.layer.shadowOpacity = 0.4;
        movableCell.layer.shadowRadius = 5;
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (NSArray *)dataSourceArrayInTableView:(MoveableTableView *)tableView{
    return _dataSource.copy;
}

- (void)tableView:(MoveableTableView *)tableView newDataSourceArrayAfterMove:(NSArray *)newDataSourceArray{
    _dataSource = newDataSourceArray.mutableCopy;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld --- %ld",indexPath.section,indexPath.row);
    NSLog(@"%@",self.dataSource[indexPath.section][indexPath.row]);
}

@end
