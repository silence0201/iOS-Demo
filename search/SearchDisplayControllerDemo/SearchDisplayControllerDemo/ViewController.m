//
//  ViewController.m
//  SearchDisplayControllerDemo
//
//  Created by 杨晴贺 on 9/7/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchBarDelegate>{
    NSArray *array ;
    NSArray *dataArray ;
    UISearchBar *searchBar ;
    UISearchDisplayController *searchDisplayController ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"搜索Demo" ;
    
    array = @[@"Aaaa",@"Abbb",@"Accc",@"Bddd",@"Beee",@"Bfff",@"Jkkk",@"Ekljljfg" ,@"Lsgfdf",@"Maaaa",@"Mfgxvc",@"Meihi",@"Casdgs",@"Awaert"] ;
    
    // 初始化一个searchBar
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) ];
    searchBar.placeholder = @"搜索" ;
    
    // 设置为自身表头
    self.tableView.tableHeaderView = searchBar ;
    
      //显示ScopeBar
        [searchBar setShowsScopeBar:YES];
        [searchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"😁", @"😂", nil]];
        searchBar.selectedScopeButtonIndex = 0;
    
    // 用searchBar初始化SearchDisplayController
    // 并把SearchDisplayController与当前controller关联起来
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self] ;
    searchDisplayController.searchResultsDelegate = self ;
    searchDisplayController.searchResultsDataSource = self ;
}

#pragma mark - TableViewDataDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return array.count ;
    }else{
        // 谓词搜索, 检查的对象是否保存输入的文本
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchDisplayController.searchBar.text] ;
        dataArray = [[NSArray alloc]initWithArray:[array filteredArrayUsingPredicate:predicate]] ;
        return dataArray.count ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] ;
    }
    
    if (tableView == self.tableView) {
        cell.textLabel.text = array[indexPath.row] ;
    }else{
        if (searchBar.selectedScopeButtonIndex == 1) {
            cell.textLabel.text = @"1``111" ;
        }else{
            cell.textLabel.text = dataArray[indexPath.row] ;
        }
    }
    return cell ;
}

//点击搜索结果的cell, 返回列表页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == searchDisplayController.searchResultsTableView) {
        [searchDisplayController setActive:NO animated:YES];
        
    }
}


@end
