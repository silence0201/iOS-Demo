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
    self.dataArray = @[@"1",@"2",@"3",@"4"] ;
    [self.view addSubview:self.topDisplay] ;
}


- (SITopDisplay *)topDisplay{
    if (!_topDisplay) {
        _topDisplay = [[SITopDisplay alloc]initWithFrame:self.view.bounds] ;
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
- (CGFloat)widthForItemInTopDisplay:(SITopDisplay *)topDisplay index:(NSInteger)index{
    return [UIScreen mainScreen].bounds.size.width / _dataArray.count ;
}
// 导航的内容
- (NSString *)topDisplayControl:(SITopDisplayControl *)topDisplayControl titleForItemAtIndex:(NSInteger)index{
    return _dataArray[index] ;
}

- (UIView *)topDisplayContent:(SITopDisplayContent *)topDisplayContent viewForItemAtIndex:(NSInteger)index{
    UIView *view = [[UIView alloc]init] ;
    if(index%2 == 0){
        view.backgroundColor = [UIColor blackColor] ;
    }else{
        view.backgroundColor = [UIColor redColor] ;
    }
    
    return view ;
}

@end
