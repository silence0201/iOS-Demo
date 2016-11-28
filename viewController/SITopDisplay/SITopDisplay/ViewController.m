//
//  ViewController.m
//  SITopDisplay
//
//  Created by 杨晴贺 on 27/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "SITopDisplay.h"

@interface ViewController ()<SITopDisplayDelegate,SITopDisplayDataSource>

@property (nonatomic,strong) SITopDisplay *topDisplay ;

@property (nonatomic,strong) NSArray *dataArray ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SITopDisplayDemo" ;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:0.8]] ;
    self.dataArray = @[@"图片1",@"图片2",@"图片3",@"图片4"] ;
    [self.view addSubview:self.topDisplay] ;
}


- (SITopDisplay *)topDisplay{
    if (!_topDisplay) {
        _topDisplay = [[SITopDisplay alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)] ;
        _topDisplay.topDisplayControl.backgroundColor = [UIColor whiteColor] ;
        _topDisplay.delegate = self ;
        _topDisplay.dataSource = self ;
        _topDisplay.titleFont = [UIFont systemFontOfSize:15.0f] ;
        _topDisplay.backgroundColor = [UIColor clearColor] ;
        _topDisplay.dividLineColor = [UIColor clearColor];
        _topDisplay.normalColor = [UIColor grayColor];
    }
    return _topDisplay ;
}

// 有多少块
- (NSInteger)numberOfItemInTopDisplay:(SITopDisplay *)topDisplay{
    return _dataArray.count ;
}

// 导航的宽
- (CGFloat)widthForItemInTopDisplay:(SITopDisplayControl *)topDisplay index:(NSInteger)index{
    return [UIScreen mainScreen].bounds.size.width / _dataArray.count ;
}
// 导航的内容
- (NSString *)topDisplayControl:(SITopDisplayControl *)topDisplayControl titleForItemAtIndex:(NSInteger)index{
    return _dataArray[index] ;
}

- (UIView *)topDisplayContent:(SITopDisplayContent *)topDisplayContent viewForItemAtIndex:(NSInteger)index{
    UIImageView *imageView = [[UIImageView alloc]init] ;
    NSString *imageName = [NSString stringWithFormat:@"%ld",index+1] ;
    imageView.image = [UIImage imageNamed:imageName] ;
    return imageView ;
}

@end
