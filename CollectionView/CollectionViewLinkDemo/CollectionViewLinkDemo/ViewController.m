//
//  ViewController.m
//  CollectionViewLinkDemo
//
//  Created by 杨晴贺 on 9/10/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "CollectionViewCell.h"
#import "CollectionViewHeaderView.h"
#import "LeftTableViewCell.h"
#import "MyCollectionViewFlowLayout.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UITableView *tableView ;
@property (nonatomic,strong) UICollectionView *collectionView ;
@property (nonatomic,strong) NSMutableArray *dataSource ;
@property (nonatomic,strong) NSMutableArray *collectionDatas ;

@end

@implementation ViewController{
    NSInteger _selectIndex ;
    BOOL _isScrollDown ;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectIndex = 0 ;
    _isScrollDown  = YES ;
    
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    [self.view addSubview:self.tableView] ;
    [self.view addSubview:self.collectionView] ;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo" ofType:@"json"] ;
    NSData *data = [NSData dataWithContentsOfFile:path] ;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] ;
    NSArray *categories = dic[@"data"][@"categories"] ;
    for(NSDictionary *dict in categories){
        CollectionCategoryModel *model = [CollectionCategoryModel objectWithDictionary:dict] ;
        [self.dataSource addObject:model] ;
        NSMutableArray *datas = [NSMutableArray array] ;
        for(SubCategoryModel *s_model in model.subcategories){
            [datas addObject:s_model] ;
        }
        [self.collectionDatas addObject:datas] ;
    }
    
    [self.tableView reloadData] ;
    [self.collectionView reloadData] ;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop] ;
}

#pragma mark - getter
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array] ;
    }
    return _dataSource ;
}

- (NSMutableArray *)collectionDatas{
    if(_collectionDatas == nil){
        _collectionDatas = [NSMutableArray array] ;
    }
    return _collectionDatas ;
}

#pragma mark - Lazy Load
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, SCREEN_HEIGHT) ] ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.tableFooterView = [UIView new] ;
        _tableView.rowHeight = 55 ;
        _tableView.showsVerticalScrollIndicator = NO ;
        _tableView.separatorColor = [UIColor clearColor] ;
        [_tableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left] ;
    }
    return _tableView ;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        MyCollectionViewFlowLayout *flowlayout = [[MyCollectionViewFlowLayout alloc]init] ;
        //设置滚动方向
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical ;
        // 左右间距
        flowlayout.minimumInteritemSpacing = 2 ;
        // 上下间距
        flowlayout.minimumLineSpacing = 2 ;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(2 + 80, 2 + 64, SCREEN_WIDTH-80-4, SCREEN_HEIGHT-64-4) collectionViewLayout:flowlayout] ;
        _collectionView.delegate = self ;
        _collectionView.dataSource = self ;
        _collectionView.showsVerticalScrollIndicator = NO ;
        _collectionView.showsHorizontalScrollIndicator = NO ;
        [_collectionView setBackgroundColor:[UIColor clearColor]] ;
        
        // 注册cell
        [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionView] ;
        // 注册分区头标题
        [self.collectionView registerClass:[CollectionViewHeaderView class]
                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                       withReuseIdentifier:@"CollectionViewHeaderView"];
        [self.view addSubview:_collectionView];
    }
    
    return _collectionView ;
}

#pragma mark - UITableView DataSource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath]  ;
    CollectionCategoryModel *model = self.dataSource[indexPath.row] ;
    cell.nameLabel.text = model.name ;
    return cell ;
}

#pragma mark - 点击标签的时候的主要逻辑
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row ;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES] ;
}

#pragma mark - UICollectionView DataSource Delegate 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CollectionCategoryModel *model = self.dataSource[section] ;
    return model.subcategories.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath] ;
    SubCategoryModel *model = self.collectionDatas[indexPath.section][indexPath.row] ;
    cell.model = model ;
    return cell ;
}

// ItemSize
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 80 - 4 - 4) / 3,
                      (SCREEN_WIDTH - 80 - 4 - 4) / 3 + 30);
}

// Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        // header
        reuseIdentifier = @"CollectionViewHeaderView";
    }
    CollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                           withReuseIdentifier:reuseIdentifier
                                  forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        CollectionCategoryModel *model = self.dataSource[indexPath.section];
        view.titleLabel.text = model.name;
    }
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 30);
}

#pragma mark - 拉动右边的主要逻辑

// 向上滑动,CollectionView分区标题即将展示,需要选择这个section
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    // 当前CollectionView滚动的方向向上，
    // CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && collectionView.dragging){
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// 向下滑动,CollectionView分区标题展示结束,需要选择下一个section
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath{
    // 当前CollectionView滚动的方向向下，
    // CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && collectionView.dragging){
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}


#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float lastOffsetY = 0;
    if (self.collectionView == scrollView){
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

@end
