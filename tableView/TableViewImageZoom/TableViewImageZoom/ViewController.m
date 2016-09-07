//
//  ViewController.m
//  TableViewImageZoom
//
//  Created by 杨晴贺 on 9/7/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

#define HeadHeight 280
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic,strong) UIImageView *headImageView ;   // 头部图片

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeadHeight)] ;
    self.headImageView.image = [UIImage imageNamed:@"header"] ;
    [self.tableView addSubview:self.headImageView] ;
    
    // 与图片的高度一样防止数据被遮挡
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeadHeight)] ;
}

// 重写这个代理方法就可以实现,利用contentOffSet进行简单设置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y ;
    
    if (offsetY < 0) {
        self.headImageView.frame = CGRectMake(offsetY/2, offsetY, SCREEN_WIDTH - offsetY, HeadHeight - offsetY) ;
    }
}

#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId] ;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row] ;
    return cell ;
}



@end
