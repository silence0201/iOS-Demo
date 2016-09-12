//
//  SearchViewController.m
//  PinYinSearchDemo
//
//  Created by 杨晴贺 on 9/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SearchViewController.h"
#import "ZYPinYinSearch.h"
#import "ChineseString.h"

#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height
#define kColor          [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong) UITableView *tableView ;
@property (nonatomic,strong) UISearchBar *searchBar ;

@property (nonatomic,strong) NSArray *allDataSource ; // 排列后的整个数据源
@property (nonatomic,copy) NSMutableArray *searchDataSource ;  //搜索结果数据源
@property (nonatomic,strong) NSArray *indexDataSource ;// 索引数据源
@property (nonatomic,assign) BOOL isSearch ;

@end

@implementation SearchViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"固定搜索框" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    [self initData] ;
    [self.view addSubview:self.tableView] ;
    [self.view addSubview:self.searchBar] ;
    
}
#pragma mark - Private Method
- (void)initData{
    _dataSource = @[@"成龙",@"梁山伯",@"Angel",@"长江1号",@"星爷",@"911",@"520ok",@"ren人",@"++family",@"中english9%+",@"武松",@"齐天大圣",@"曹操",@"林黛玉",@"Bob",@"夏勒特",@"神雕侠"];
    _searchDataSource = [NSMutableArray array] ;
    // 获取索引的首字母
    _indexDataSource = [ChineseString IndexArray:_dataSource] ;
    NSLog(@"%@",_indexDataSource) ;
    // 对原数据进行排序分组
    _allDataSource = [ChineseString LetterSortArray:_dataSource] ;
    NSLog(@"%@",_allDataSource) ;
}

#pragma mark - Lazy Load
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight) ];
        _tableView.backgroundColor = kColor ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
    }
    return _tableView ;
}

- (UISearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)] ;
        _searchBar.delegate = self ;
        _searchBar.placeholder = @"请输入搜索内容" ;
    }
    return _searchBar ;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!_isSearch) {
        return _indexDataSource.count ;
    }else{
        return 1 ;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_isSearch) {
        return [_allDataSource[section] count];
    }else {
        return _searchDataSource.count;
    }
}

// 头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(!_isSearch){
        return _indexDataSource[section] ;
    }else{
        return nil ;
    }
}

// 右侧索引列表
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if(!_isSearch){
        return _indexDataSource ;
    }else{
        return nil ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone] ;
        
    }
    if(!_isSearch){
        cell.textLabel.text = _allDataSource[indexPath.section][indexPath.row] ;
    }else{
        cell.textLabel.text = _searchDataSource[indexPath.row] ;
    }
    return cell ;
}

// 索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:index animated:YES] ;
    return index ;
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [_searchDataSource removeAllObjects] ;
    NSArray *array = [ZYPinYinSearch searchWithOriginalArray:_dataSource andSearchText:searchText andSearchByPropertyName:@"name"] ;
    if(searchText.length == 0){
        _isSearch = NO ;
        [_searchDataSource addObjectsFromArray:_allDataSource] ;
    }else{
        _isSearch = YES ;
        [_searchDataSource addObjectsFromArray:array] ;
    }
    [self.tableView reloadData] ;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBarHidden = YES ;
        _searchBar.frame = CGRectMake(0, 20, kScreenWidth, 44) ;
        _searchBar.showsCancelButton = YES ;
    }] ;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.3 animations:^{
        _searchBar.frame = CGRectMake(0, 64, kScreenWidth, 44) ;
        self.navigationController.navigationBarHidden = NO ;
        _searchBar.showsCancelButton = NO ;
    }] ;

    [_searchBar resignFirstResponder] ;
    _searchBar.text = @"" ;
    _isSearch = NO ;
    [_tableView reloadData] ;
}

@end
