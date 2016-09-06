//
//  LeftViewController.m
//  SpreadDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "LeftViewController.h"
#import "SWRevealViewController.h"
#import "RedViewController.h"
#import "GrayViewController.h"
#import "BlueViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView ;
@property (nonatomic,strong)NSArray *menuArray ;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData] ;
    [self initView] ;
}

- (void)initData{
    self.menuArray = @[@"灰色控制器",@"蓝色控制器",@"红色控制器"] ;
}

- (void)initView{
    self.view.backgroundColor = [UIColor lightGrayColor] ;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStyleGrouped] ;
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    [self.view addSubview:self.tableView] ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reusableID = @"cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableID] ;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableID] ;
    }
    cell.textLabel.text = _menuArray[indexPath.row] ;
    return  cell ;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SWRevealViewController *revealViewController = self.revealViewController ;
    UIViewController *viewController ;
    switch (indexPath.row) {
        case 0:
            viewController = [[GrayViewController alloc]init] ;
            break;
        case 1:
            viewController = [[BlueViewController alloc]init] ;
            break ;
        case 2:
            viewController = [[RedViewController alloc]init] ;
            break ;
        default:
            break;
    }
    
    // 调用pushFrontViewController进行页面切换
    [revealViewController pushFrontViewController:viewController animated:YES] ;
}




@end
