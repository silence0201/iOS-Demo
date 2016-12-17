//
//  MainViewController.m
//  iPadDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MainViewController.h"
#import "Dock.h"

@interface MainViewController ()<DockDelegate>

@property (nonatomic,strong) Dock *dock ;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]] ;
    [self setupDock] ;
}

- (void)setupDock{
    BOOL isLandspace = self.view.width >= kLandspaceWidth ;
    [self.dock rolateToLandscape:isLandspace] ;
    [self.view addSubview:self.dock] ;
    // 必须初始化View的高度
    self.dock.height = self.view.height ;
    // 获取屏幕的方向,设置相应的frame
    if(isLandspace){
        self.dock.width = kDockLandspaceWidth ;
    }else{
        self.dock.width = kDockPortraitWidth ;
    }
    [self.dock rolateToLandscape:isLandspace] ;

}

- (Dock *)dock{
    if(!_dock){
        _dock = [[Dock alloc]init] ;
        _dock.autoresizingMask = UIViewAutoresizingFlexibleHeight ;
//        _dock.backgroundColor = [UIColor redColor] ;
        _dock.delegate = self ;
    }
    return _dock ;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    BOOL isLandspace = size.width >= kLandspaceWidth ;
    
    CGFloat duration = [coordinator transitionDuration] ;
    [UIView animateWithDuration:duration animations:^{
        self.dock.width = isLandspace?kDockLandspaceWidth : kDockPortraitWidth ;
        [self.dock rolateToLandscape:isLandspace] ;
    }] ;
}

@end
