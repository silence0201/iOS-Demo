//
//  ViewController.m
//  NavigationBarDemo
//
//  Created by 杨晴贺 on 8/8/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "MXNavigationBarManager.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static NSString *const CellIdentifer = @"CellIdentifer";
static const CGFloat headerImageHeight = 260.0f;

@interface ViewController ()

@end

@implementation ViewController


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData] ;
    
    [self initBarManager] ;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    // 恢复
    [MXNavigationBarManager reStoreWithZeroStatus];
}

#pragma mark - 初始化
- (void)initData{
    self.title = @"导航栏测试" ;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifer] ;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerImageHeight) ];
    
    imageView.image = [UIImage imageNamed:@"headerImage"] ;
    
    self.tableView.tableHeaderView = imageView ;
    self.tableView.contentOffset = CGPointMake(0, 64);
}

- (void)initBarManager{
    // 保存状态栏的状态
    [MXNavigationBarManager saveWithController:self] ;
    
    // 必须设置
    [MXNavigationBarManager managerWithController:self] ;  // 进行管理
    [MXNavigationBarManager setBarColor:[UIColor colorWithRed:0.5 green:0.5 blue:1 alpha:1]] ;  // 设置bar颜色
    [MXNavigationBarManager setTintColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]] ;  // tint颜色
    [MXNavigationBarManager setStatusBarStyle:UIStatusBarStyleDefault];  // 设置状态栏样式
    [MXNavigationBarManager setZeroAlphaOffset:-64];   // 没有透明的位置
    [MXNavigationBarManager setFullAlphaOffset:200];   // 全部透明的位置
    [MXNavigationBarManager setFullAlphaTintColor:[UIColor whiteColor]];  // 透明时tint颜色
    [MXNavigationBarManager setFullAlphaBarStyle:UIStatusBarStyleLightContent];  // 透明时状态栏样式
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 改变位置
    [MXNavigationBarManager changeAlphaWithCurrentOffset:scrollView.contentOffset.y];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer forIndexPath:indexPath] ;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row] ;
    return cell ;
}



@end
