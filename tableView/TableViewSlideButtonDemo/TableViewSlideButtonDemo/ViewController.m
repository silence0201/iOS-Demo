//
//  ViewController.m
//  TableViewSlideButtonDemo
//
//  Created by 杨晴贺 on 8/10/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define CellIdentifier @"CellIdentifier"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

// tableView
@property (nonatomic,strong) UITableView *tableView ;

// 数据源
@property (nonatomic,strong) NSMutableArray *dataSource ;

@end

@implementation ViewController

// 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化数据源
    self.dataSource = [@[@"灼眼的夏娜",@"零之使魔",@"旋风管家！",@"龙与虎",@"亚斯塔萝黛的后宫玩具",@"龙之界点",@"绯弹的亚里亚"] mutableCopy] ;
    // 初始化TableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain] ;
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier] ;
    
    [self.view addSubview:_tableView] ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    cell.textLabel.text = self.dataSource[indexPath.row] ;
    return cell ;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f ;
}

// 实现更多按钮的代理方法
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 删除
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了删除按钮") ;
        [self.dataSource removeObjectAtIndex:indexPath.row] ;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop] ;
    }] ;
    deleteAction.backgroundColor = [UIColor redColor] ;
    
    //更多
    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了更多按钮") ;
        [tableView reloadData] ;
    }] ;
    moreAction.backgroundColor = [UIColor orangeColor] ;
    
    // 置顶
    UITableViewRowAction *topAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.dataSource insertObject:self.dataSource[indexPath.row] atIndex:0] ;
        [self.dataSource removeObjectAtIndex:indexPath.row + 1] ;
        [tableView reloadData] ;
    }] ;
    
    return @[deleteAction,moreAction,topAction] ;
}


@end
