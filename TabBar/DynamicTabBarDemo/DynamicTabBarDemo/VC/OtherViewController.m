//
//  OtherViewController.m
//  DynamicTabBarDemo
//
//  Created by 杨晴贺 on 07/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "OtherViewController.h"

#define KScreen_Width [UIScreen mainScreen].bounds.size.width
#define KScreen_Height [UIScreen mainScreen].bounds.size.height
static CGFloat const imageBGHeight = 200; // 背景图片的高度
static NSString * const identifier = @"cell"; // cell重用标识符


@interface OtherViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView ;
@property (nonatomic,strong) UIImageView *imageBG ;
@property (nonatomic,strong) UILabel *titleLabel ;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav] ;
    [self.view addSubview:self.tableView] ;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.contentInset = UIEdgeInsetsMake(imageBGHeight, 0, 0, 0) ;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier] ;
        [_tableView addSubview:self.imageBG] ;
    }
    return _tableView ;
}

- (UIImageView *)imageBG{
    if(!_imageBG){
        _imageBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, -imageBGHeight, KScreen_Width, imageBGHeight)] ;
        _imageBG.image = [UIImage imageNamed:@"BGImage"] ;
        _imageBG.contentMode = UIViewContentModeScaleAspectFill ;
    }
    return _imageBG ;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.text=@"自定义Title";
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel sizeToFit];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.alpha = 0;
    }
    return _titleLabel;
}

- (void)setupNav{
    [self.navigationController.navigationBar setShadowImage:[UIImage new]] ;
    self.navigationItem.titleView = self.titleLabel ;
}

#pragma mark - tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据--%zd", indexPath.row];
    return cell;
}

#pragma mark -  重点的地方在这里 滚动时候进行计算
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = imageBGHeight + offsetY;
    if (offsetH < 0) {
        CGRect frame = self.imageBG.frame;
        frame.size.height = imageBGHeight - offsetH;
        frame.origin.y = -imageBGHeight + offsetH;
        self.imageBG.frame = frame;
    }
    
    CGFloat alpha = offsetH / imageBGHeight;
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor cyanColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    self.titleLabel.alpha = alpha;
}

#pragma mark - 返回一张纯色图片
/** 返回一张纯色图片 */
- (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

@end
