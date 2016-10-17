//
//  CitySelectViewController.m
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CitySelectViewController.h"
#import "ViewController.h"
#import "HeadView.h"
#import "CityViewCell.h"
#import "ItemViewCell.h"
#import "SearchResult.h"
#import "MySearchController.h"
#import "MySearchTableViewController.h"
#import "NSMutableArray+FilterElement.h"

//设备物理尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)

#import <CoreLocation/CoreLocation.h>

@interface CitySelectViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,SearchResultsDelegate,CityViewCellDelegate>{
    UITableView *_tableView ;
    HeadView *_cellHeadView ;
    NSMutableArray *_loactionCity ;  //  当前城市
    NSMutableArray *_dataArray ;  // 定位
    NSMutableDictionary *_allCitysDictionary ;  //所有数据字典
    NSMutableArray *_keys ;  // 城市首字母
}

@property (nonatomic, strong)MySearchController *searchController; //搜索的控制器
@property (nonatomic, strong)NSMutableArray *searchList; //搜索结果的数组
@property (nonatomic, strong)MySearchTableViewController *searchResultController; //搜索的结果控制器
@property(strong,nonatomic)NSMutableArray *allCityArray;  //所有城市数组
@property (nonatomic, strong) CLLocationManager *locationManager; //定位

@end

@implementation CitySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Lazy Load
- (NSMutableArray *)allCityArray{
    if (!_allCityArray) {
        _allCityArray = [NSMutableArray array];
    }
    return _allCityArray;
}

- (NSMutableArray *)searchList{
    if (!_searchList) {
        _searchList = [NSMutableArray array];
    }
    return _searchList;
}

- (void)loadData{
    _dataArray=[NSMutableArray array];
    //定位城市
    _loactionCity=[NSMutableArray arrayWithObject:@"北京市"];
    [_dataArray addObject:_loactionCity];
    
    //最近访问
    NSArray *recentArray=[NSArray arrayWithObjects:@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市", nil];
    [_dataArray addObject:recentArray];
    
    //热门城市
    NSArray *hotCity=[NSArray arrayWithObjects:@"广州市",@"北京市",@"天津市",@"西安市",@"重庆市",@"沈阳市",@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市", nil];
    [_dataArray addObject:hotCity];
    
    //索引城市
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    _allCitysDictionary=[NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    //将所有城市放到一个数组里
    for (NSArray *array in _allCitysDictionary.allValues) {
        for (NSString *citys in array) {
            [self.allCityArray addObject:citys];
        }
    }
    
    _keys=[NSMutableArray array];
    [_keys addObjectsFromArray:[[_allCitysDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    //添加多余三个索引
    [_keys insertObject:@"Θ" atIndex:0];
    [_allCitysDictionary setObject:hotCity forKey:@"Θ"];
    [_keys insertObject:@"♡" atIndex:0];
    [_allCitysDictionary setObject:recentArray forKey:@"♡"];
    [_keys insertObject:@"◎" atIndex:0];
    [_allCitysDictionary setObject:_loactionCity forKey:@"◎"];
}

- (void)initTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    _tableView.sectionIndexColor = RGB(150, 150, 150);
    [self.view addSubview:_tableView];
}

@end
