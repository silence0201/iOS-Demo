//
//  MainViewController.m
//  DynamicTabBarDemo
//
//  Created by 杨晴贺 on 07/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView ;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView] ;
    self.view.backgroundColor = [UIColor lightGrayColor] ;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MainTableViewCell"] ;
    }
    return _tableView ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据-%ld",indexPath.row];
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < 0){
        // 向下滑动
        [UIView animateWithDuration:1 animations:^{
            self.tabBarController.tabBar.transform = CGAffineTransformIdentity ;
            self.navigationController.navigationBar.alpha = 1 ;
        }] ;
    }else{
        // 向上滑动
        [UIView animateWithDuration:1 animations:^{
            self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49) ;
            [UIView animateWithDuration:5 animations:^{
                self.navigationController.navigationBar.alpha = 0 ;
            }] ;
        }] ;
    }
}

@end
