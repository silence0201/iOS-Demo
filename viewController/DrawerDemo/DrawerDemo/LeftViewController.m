//
//  LeftViewController.m
//  DrawerDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView ;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"右侧详情" ;
    [self.view addSubview:self.tableView] ;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
        imageView.image = [UIImage imageNamed:@"4"] ;
        imageView.contentMode = UIViewContentModeScaleAspectFill ;
        _tableView.backgroundView = imageView ;
    }
    return _tableView ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"Cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName] ;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName] ;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    cell.backgroundColor = [UIColor clearColor] ;
    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld",indexPath.row] ;
    return cell ;
}
@end
