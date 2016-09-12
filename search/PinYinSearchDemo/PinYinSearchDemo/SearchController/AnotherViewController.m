//
//  AnotherViewController.m
//  PinYinSearchDemo
//
//  Created by 杨晴贺 on 9/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AnotherViewController.h"
#import "ZYPinYinSearch.h"
#import "ChineseString.h"

#define kColor [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];

@interface AnotherViewController ()<UISearchResultsUpdating>

// 必须要求ios8以上才能使用该api
@property (nonatomic,strong) UISearchController *searchController ;
@property (nonatomic,strong) NSArray *allDataSource ;  // 排列后的数据源
@property (nonatomic,copy) NSMutableArray *searchDataSource ;  // 搜索的结果
@property (nonatomic,strong) NSArray *indexDataSource ; // 索引数据源


@end

@implementation AnotherViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData] ;
    self.tableView.backgroundColor = kColor ;
    self.title = @"随着滚动的搜索框" ;
    self.tableView.tableHeaderView = self.searchController.searchBar ;
    
}

#pragma mark - Lazy Load 
- (UISearchController *)searchController{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil] ;
        _searchController.searchResultsUpdater = self ;
        _searchController.dimsBackgroundDuringPresentation = NO ;
        _searchController.hidesNavigationBarDuringPresentation = YES ;
        _searchController.searchBar.placeholder = @"请输入搜索的关键字" ;
        [_searchController.searchBar sizeToFit] ;
    }
    return _searchController ;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.searchController.active) {
        return _allDataSource.count ;
    }else{
        return 1 ;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.searchController.active) {
        return [_allDataSource[section] count] ;
    }else{
        return _searchDataSource.count ;
    }
}

// 头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(!self.searchController.active){
        return _indexDataSource[section] ;
    }else{
        return nil ;
    }
}

// 右侧索引列表
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if(!self.searchController.active){
        return _indexDataSource ;
    }else{
        return nil ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone] ;
    }
    if (!self.searchController.active) {
        cell.textLabel.text = _allDataSource[indexPath.section][indexPath.row] ;
    }else{
        cell.textLabel.text = _searchDataSource[indexPath.row] ;
    }
    
    return cell ;
}

#pragma mark - UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [_searchDataSource removeAllObjects] ;
    NSArray *array  = [ZYPinYinSearch searchWithOriginalArray:_dataSource andSearchText:searchController.searchBar.text andSearchByPropertyName:@"name"] ;
    if (searchController.searchBar.text.length == 0) {
        [_searchDataSource addObjectsFromArray:_dataSource] ;
    }else{
        [_searchDataSource addObjectsFromArray:array] ;
    }
    [self.tableView reloadData] ;
}

#pragma mark - Private Method
- (void)initData{
    _dataSource = @[@"成龙",@"梁山伯",@"Angel",@"长江1号",@"星爷",@"911",@"520ok",@"ren人",@"++family",@"中english9%+",@"武松",@"齐天大圣",@"曹操",@"林黛玉",@"Bob",@"夏勒特",@"神雕侠"];
    _searchDataSource = [NSMutableArray array] ;
    // 获取索引的首字母
    _indexDataSource = [ChineseString IndexArray:_dataSource] ;
    // 对源数据进行排序重新分组
    _allDataSource = [ChineseString LetterSortArray:_dataSource] ;
}

@end
