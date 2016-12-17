//
//  ViewController.m
//  FPSDemo
//
//  Created by 杨晴贺 on 15/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "FPSLabel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView ;

@property (nonatomic,strong) FPSLabel *fpsLabel ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView] ;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.fpsLabel] ;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]] ;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault] ;
}

- (FPSLabel *)fpsLabel{
    if (!_fpsLabel) {
        _fpsLabel = [[FPSLabel alloc]init] ;
    }
    return _fpsLabel ;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
        imageView.image = [UIImage imageNamed:@"2"] ;
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]] ;
        effectView.frame = self.view.bounds ;
        [imageView addSubview:effectView] ;
        _tableView.backgroundView = imageView ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _tableView.allowsSelection = NO ;
    }
    return _tableView ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5000 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行数据",indexPath.row] ;
    cell.backgroundColor = [UIColor clearColor] ;
    return cell ;
}


@end
