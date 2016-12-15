//
//  ViewController.m
//  YYImageDemo
//
//  Created by 杨晴贺 on 15/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *titleArray ;
@property (nonatomic,strong) NSArray *classArray ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"YYImage简单使用" ;
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.tableView.bounds] ;
    imageView.image = [UIImage imageNamed:@"2"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    self.tableView.backgroundView = imageView ;
    UIVisualEffectView *effctView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]] ;
    effctView.frame = imageView.bounds ;
    [imageView addSubview:effctView] ;
    self.tableView.backgroundView = imageView ;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self initData] ;
}

- (void)initData{
    self.titleArray = @[@"Animated Image",@"Web Image"] ;
    self.classArray = @[@"ImageDisplayExample",@"WebImageExample"] ;
}

#pragma mark ---- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"] ;
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] ;
    }
    cell.textLabel.text = _titleArray[indexPath.row] ;
    cell.backgroundColor = [UIColor clearColor] ;
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = _classArray[indexPath.row] ;
    Class clazz = NSClassFromString(className) ;
    if(clazz){
        UIViewController *vc = [[clazz alloc]init] ;
        vc.title = _titleArray[indexPath.row] ;
        [self.navigationController pushViewController:vc animated:YES] ;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES] ;
}



@end
