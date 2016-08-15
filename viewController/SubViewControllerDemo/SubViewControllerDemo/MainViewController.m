//
//  MainViewController.m
//  SubViewControllerDemo
//
//  Created by 杨晴贺 on 8/15/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MainViewController.h"
#import "FirstTableViewController.h"
#import "SecondTableViewController.h"
#import "ThirdTableViewController.h"
#import "FourthTableViewController.h"
#import "FifthTableViewController.h"
#import "SixTableViewController.h"

//get the width of the screen
#define SCR_W [UIScreen mainScreen].bounds.size.width

//get the width of the screen
#define SCR_H [UIScreen mainScreen].bounds.size.height

//custom RGB color
#define RGB(__r,__g,__b) [UIColor colorWithRed:(__r) / 255.0 green:(__g) / 255.0 blue:(__b) / 255.0 alpha:1]

#define topButtonWidth 100

@interface MainViewController ()<UIScrollViewDelegate>{
    UIScrollView *_topScrollView ;
    UIScrollView *_mainScrollView ;
    
    NSMutableArray *_topButtons ;
    NSMutableArray *_titles ;
    NSMutableArray *_viewControllers ;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor  = [UIColor whiteColor] ;
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor] ;
    _topButtons = [NSMutableArray array] ;
    _titles = [NSMutableArray array] ;
    
    [self setTopScrollView] ;
    [self setMainScrollView] ;

}

- (void)setTopScrollView{
    _titles =[ @[@"推荐",@"娱乐",@"新闻",@"科技",@"体育",@"热点"] mutableCopy];
    _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 20, SCR_W-20, 40) ];
    _topScrollView.showsVerticalScrollIndicator = NO ;
    _topScrollView.showsHorizontalScrollIndicator = NO ;
    _topScrollView.backgroundColor = [UIColor clearColor] ;
    
    for(NSInteger i = 0 ; i < _titles.count ; i++){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i * topButtonWidth, 0, topButtonWidth, 40)] ;
        [button setTitleColor:RGB(151,194,219) forState:UIControlStateNormal] ;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected] ;
        [button setTitle:_titles[i] forState:UIControlStateNormal] ;
        [_topButtons addObject:button] ;
        [_topScrollView addSubview:button] ;
        button.tag = 1000 + i ;
        [button addTarget:self action:@selector(clickTopButton:) forControlEvents:UIControlEventTouchUpInside] ;
    }
    
    ((UIButton *)_topButtons[1]).selected = YES ;
    [_topScrollView setContentSize:CGSizeMake(_titles.count * topButtonWidth, 40) ];
    
    if(_topScrollView.contentSize.width - _topScrollView.frame.size.width <0)
    {
        [_topScrollView setContentOffset:CGPointMake(-(_topScrollView.frame.size.width - _topScrollView.contentSize.width)/2, 0) animated:NO];
    }
    [self.navigationController.view addSubview:_topScrollView];
}

- (void)clickTopButton:(UIButton *)button{
    for (UIButton *button in _topButtons) {
        if (button.selected == YES) {
            button.selected = NO;
        }
    }
    button.selected = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        [_mainScrollView setContentOffset:CGPointMake((button.tag - 1000) * SCR_W, 0)];
    }];
    
    //点击按钮的时候,topScrollView移动
    [self setMoveScrollViewContentOffsetWithCurrentClickView:button andMoveScrollView:_topScrollView];
}

- (void)setMainScrollView{
    FirstTableViewController *firstVC = [[FirstTableViewController alloc] init];
    SecondTableViewController *secondVC = [[SecondTableViewController alloc] init];
    ThirdTableViewController *thirdVC = [[ThirdTableViewController alloc] init];
    FourthTableViewController *fourthVC = [[FourthTableViewController alloc] init];
    FifthTableViewController *fifthVC = [[FifthTableViewController alloc] init];
    SixTableViewController *sixVC = [[SixTableViewController alloc] init];
    
    _viewControllers =[ @[firstVC,secondVC,thirdVC,fourthVC,fifthVC,sixVC] mutableCopy] ;
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H)] ;
    [_mainScrollView setContentSize:CGSizeMake(SCR_W * _viewControllers.count, SCR_H)] ;
    
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    
    [_mainScrollView setContentOffset:CGPointMake(SCR_W, 0)];
    
    NSInteger i = 0;
    for (UIViewController *viewController in _viewControllers) {
        viewController.view.frame = CGRectMake(i * SCR_W, 0, SCR_W, _mainScrollView.frame.size.height);
        [_mainScrollView addSubview:viewController.view];
        i ++;
    }
    [self.view addSubview:_mainScrollView];
    
    
}

/**
 *  根据点击的view,设置合适的移动距离
 *
 *  @param currentClickview 当前点击的空间
 *  @param moveScrollView   整个ScrollView
 */
- (void)setMoveScrollViewContentOffsetWithCurrentClickView:(UIView *)currentClickview andMoveScrollView:(UIScrollView *)moveScrollView
{
    if(moveScrollView.contentSize.width - moveScrollView.frame.size.width < 0)
        return;
    CGFloat x = currentClickview.frame.origin.x - (moveScrollView.frame.size.width - currentClickview.frame.size.width)/2;
    if(x > (moveScrollView.contentSize.width - moveScrollView.frame.size.width))
    {
        x = moveScrollView.contentSize.width - moveScrollView.frame.size.width;
    }
    else if(x < 0)
    {
        x = 0;
    }
    [moveScrollView setContentOffset:CGPointMake(x, currentClickview.frame.origin.y) animated:YES];
}

#pragma mark - UIscrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 设置Button的选中情况
    for (UIButton *button in _topButtons) {
        if (button.selected == YES) {
            button.selected = NO;
        }
    }
    ((UIButton *)[_topButtons objectAtIndex:scrollView.contentOffset.x / SCR_W]).selected = YES;
    
    //滑动主界面ScrollView的时候,topScrollView移动
    [self setMoveScrollViewContentOffsetWithCurrentClickView:((UIButton *)[_topButtons objectAtIndex:scrollView.contentOffset.x / SCR_W]) andMoveScrollView:_topScrollView];
}

@end
