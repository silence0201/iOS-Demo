//
//  ViewController.m
//  LinkSelectDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "Model.h"
#import "TableViewHeaderView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *categroryData ;
@property (nonatomic,strong) NSMutableArray *foodData ;
@property (nonatomic,strong) UITableView *leftTableView ;
@property (nonatomic,strong) UITableView *rightTableView ;

@end

@implementation ViewController{
    NSInteger _selectIndex ;
    BOOL _isScrollDown ;
}

#pragma mark - life cycle
- (void)viewDidLoad{
    [super viewDidLoad] ;
    
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    _selectIndex = 0 ;
    _isScrollDown = YES ;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"meituan" ofType:@"json"] ;
    NSData *data = [NSData dataWithContentsOfFile:path] ;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] ;
    
    NSArray *foods = dic[@"data"][@"food_spu_tags"] ;
    
    for(NSDictionary *dic in foods){
        CategoryModel *model = [CategoryModel objectWithDictionary:dic] ;
        [self.categroryData addObject:model] ;
        
        NSMutableArray *datas = [NSMutableArray array] ;
        for(FoodModel *food_model in model.spus){
            [datas addObject:food_model] ;
        }
        [self.foodData addObject:datas] ;
    }
    
    [self.view addSubview:self.leftTableView] ;
    [self.view addSubview:self.rightTableView] ;
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop] ;
}

#pragma mark - getter
- (NSMutableArray *)categroryData{
    if (!_categroryData) {
        _categroryData = [NSMutableArray array] ;
    }
    return _categroryData ;
}

- (NSMutableArray *)foodData{
    if (!_foodData) {
        _foodData = [NSMutableArray array] ;
    }
    return _foodData ;
}

#pragma mark - Lazy load
- (UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, SCREEN_HEIGHT) ] ;
        _leftTableView.delegate = self ;
        _leftTableView.dataSource = self ;
        _leftTableView.rowHeight = 55 ;
        _leftTableView.tableFooterView = [[UIView alloc]init];
        _leftTableView.showsVerticalScrollIndicator = NO ;
        _leftTableView.separatorColor = [UIColor clearColor] ;
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left] ;
    }
    return _leftTableView ;
}

- (UITableView *)rightTableView{
    if(!_rightTableView){
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(80, 64, SCREEN_WIDTH - 80, SCREEN_HEIGHT)] ;
        _rightTableView.delegate = self ;
        _rightTableView.dataSource = self ;
        _rightTableView.rowHeight = 80 ;
        _rightTableView.showsVerticalScrollIndicator = NO ;
        [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Right] ;
    }
    return _rightTableView ;
}

#pragma mark - TableView DataSource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_leftTableView == tableView){
        return 1 ;
    }else{
        return self.categroryData.count ;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_leftTableView == tableView) {
        return self.categroryData.count ;
    }else{
        return [self.foodData[section] count] ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_leftTableView == tableView){
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left] ;
        CategoryModel *model = self.categroryData[indexPath.row] ;
        cell.nameLabel.text = model.name ;
        return cell ;
    }else{
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Right] ;
        FoodModel *model = self.foodData[indexPath.section][indexPath.row] ;
        cell.model = model ;
        return cell ;
    }
}

#pragma mark - TableView  Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(_rightTableView == tableView){
        return 20.0f ;
    }else{
        return 0 ;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_rightTableView == tableView) {
        TableViewHeaderView *headerView = [[TableViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)] ;
        CategoryModel *model = self.categroryData[section] ;
        headerView.nameLabel.text = model.name ;
        return headerView ;
    }
    return nil ;
}

#pragma mark - 滚动联动效果的实现
// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，
    // RightTableView滚动的方向向上，
    // RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && !_isScrollDown && _rightTableView.dragging){
        [self selectRowAtIndex:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，
    // RightTableView滚动的方向向下，
    // RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && _isScrollDown && _rightTableView.dragging){
        [self selectRowAtIndex:section + 1];
    }
}

// 左侧TableView点击滚动效果
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_leftTableView == tableView){
        _selectIndex = indexPath.row ;
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES] ;
    }
}

#pragma mark - Private Method
// 当拖动右边的TableView的时候.处理左边的TableView
- (void)selectRowAtIndex:(NSInteger)index{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop] ;
}

#pragma mark - UIScrollViewDelegate
// 标记一下RightTableView的滚动方向
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static CGFloat lastOffSetY = 0 ;
    UITableView *tableView = (UITableView *)scrollView ;
    if(_rightTableView == tableView){
        _isScrollDown = lastOffSetY < scrollView.contentOffset.y ;
        lastOffSetY = scrollView.contentOffset.y ;
    }
}

@end
