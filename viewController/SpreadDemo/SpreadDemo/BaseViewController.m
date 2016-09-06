//
//  BaseViewController.m
//  SpreadDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "BaseViewController.h"
#import "SWRevealViewController.h"



@interface BaseViewController ()

@property (nonatomic,strong) NSArray *operateTitleArray ;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initView{
    // 导航bar
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)] ;
    _navBarHeight = 60 ;
    containerView.backgroundColor = [UIColor greenColor] ;
    [self.view addSubview:containerView] ;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40)] ;
    label.textAlignment = NSTextAlignmentCenter ;
    label.text = [self controllerTitle] ;
    label.textColor = [UIColor whiteColor] ;
    [containerView addSubview:label] ;
    
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    // 注册该页面可以执行滑动切换
    SWRevealViewController *revealViewController = self.revealViewController ;
    [self.view addGestureRecognizer:revealViewController.panGestureRecognizer] ;
}

- (NSString *)controllerTitle{
    return @"默认标题" ;
}




@end
