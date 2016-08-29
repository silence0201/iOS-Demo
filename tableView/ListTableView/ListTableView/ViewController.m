//
//  ViewController.m
//  ListTableView
//
//  Created by 杨晴贺 on 8/29/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "Friend.h"
#import "FriendCell.h"
#import "FriendGroup.h"
#import "HeaderView.h"

@interface ViewController () <HeadViewDelegate>

@property (nonatomic,strong) NSMutableArray *groups ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // cell 高度
    self.tableView.rowHeight = 50 ;
    
    // head高度
    self.tableView.sectionHeaderHeight = 44 ;
}
// 加载数据
- (NSMutableArray *)groups{
    if (_groups == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"friends.plist" ofType:nil] ;
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path] ;
        NSMutableArray *groupArray = [NSMutableArray array] ;
        for(NSDictionary *dic in dicArray){
            FriendGroup *group = [FriendGroup groupWithDic:dic] ;
            [groupArray addObject:group] ;
        }
        _groups = groupArray ;
    }
    return _groups ;
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FriendGroup *group = self.groups[section] ;
    return (group.isOpen ? group.friends.count : 0) ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 创建cell
    FriendCell *cell = [FriendCell cellWithTableView:tableView] ;
    
    // 设置cell的数据
    FriendGroup *group = self.groups[indexPath.section] ;
    cell.friendData = group.friends[indexPath.row] ;
    
    return cell ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderView *headerView = [HeaderView headerViewWithTableView:tableView] ;
    // 设置代理
    headerView.delegate = self ;
    
    // 设置数据
    headerView.group = self.groups[section] ;
    
    return headerView ;
}

#pragma mark - HeaderViewDelegate
- (void)headerViewDidClickedNameView:(HeaderView *)headView{
    [self.tableView reloadData] ;
}

#pragma mark - 操作按钮
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *delAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点了删除按钮") ;
        NSMutableArray *array = [self.groups[indexPath.section] friends] ;
        [array removeObjectAtIndex:indexPath.row] ;
        [self.tableView reloadData] ;
    }];
    delAction.backgroundColor = [UIColor redColor] ;
    
    UITableViewRowAction *topAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"你点了置顶按钮") ;
        NSMutableArray *array = [self.groups[indexPath.section] friends] ;
        [array exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0] ;
        [self.tableView reloadData] ;
    }] ;
    topAction.backgroundColor = [UIColor orangeColor] ;
    
    return @[delAction,topAction] ;
}


@end
