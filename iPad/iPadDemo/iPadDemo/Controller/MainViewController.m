//
//  MainViewController.m
//  iPadDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MainViewController.h"
#import "IconButton.h"
#import "Dock.h"

#import "AllStatusViewController.h"
#import "RelatedViewController.h"
#import "PhotoWallViewController.h"
#import "ElectronicPhotoFrameViewController.h"
#import "FriendsViewController.h"
#import "MoreViewController.h"

#import "ModelViewController.h"
#import "PhotoViewController.h"
#import "BlogViewController.h"

#import "AboutViewController.h"



@interface MainViewController ()<DockDelegate>

@property (nonatomic,strong) Dock *dock ;
@property (nonatomic,strong) UIView *contentView ;

@property (nonatomic,assign) NSInteger currentIndex ;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]] ;
    // 初始化Dock
    [self setupDock] ;
    // 初始化控制器
    [self setupControllers] ;
    // 初始化内容视图
    [self setupContent] ;
    // 默认进来选择个人中心
    [self clickIconButton:nil] ;
}

- (void)setupDock{
    BOOL isLandspace = self.view.width >= kLandspaceWidth ;
    [self.view addSubview:self.dock] ;
    // 必须初始化View的高度
    self.dock.height = self.view.height ;
    // 获取屏幕的方向,设置相应的frame
    [self.dock rolateToLandscape:isLandspace] ;
}

- (void)setupContent{
    self.contentView.height = self.view.height - 20 ;
    self.contentView.left = self.dock.width ;
    self.contentView.top = 20 ;
    self.contentView.width = self.view.width - self.dock.width ;
    [self.view addSubview:self.contentView] ;
}

- (void)setupControllers{
    AllStatusViewController *allStatus = [AllStatusViewController new] ;
    [self packWithNav:allStatus] ;
    
    RelatedViewController *relate = [RelatedViewController new] ;
    [self packWithNav:relate] ;
    
    PhotoWallViewController *photoWall = [PhotoWallViewController new] ;
    [self packWithNav:photoWall] ;
    
    ElectronicPhotoFrameViewController *ele = [ElectronicPhotoFrameViewController new] ;
    [self packWithNav:ele] ;
    
    FriendsViewController *friends = [FriendsViewController new] ;
    [self packWithNav:friends] ;
    
    MoreViewController *more = [MoreViewController new] ;
    [self packWithNav:more] ;
    
    AboutViewController *about = [AboutViewController new] ;
    [self packWithNav:about] ;
}

- (void)packWithNav:(UIViewController *)vc{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc] ;
    [self addChildViewController:nav] ;
}

- (void)presentWithNav:(UIViewController *)vc{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc] ;
    nav.modalPresentationStyle = UIModalPresentationFormSheet ;
    [self presentViewController:nav animated:YES completion:nil] ;
}

- (Dock *)dock{
    if(!_dock){
        _dock = [[Dock alloc]init] ;
        _dock.autoresizingMask = UIViewAutoresizingFlexibleHeight ;
        _dock.delegate = self ;
    }
    return _dock ;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init] ;
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    return _contentView ;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    BOOL isLandspace = size.width >= kLandspaceWidth ;
    
    CGFloat duration = [coordinator transitionDuration] ;
    [UIView animateWithDuration:duration animations:^{
        [self.dock rolateToLandscape:isLandspace] ;
        
        self.contentView.left = self.dock.width ;
    }] ;
}

#pragma mark --- DockDelegate

- (void)bottomMenu:(BottomMenu *)bottomMenu withType:(BottomMenuType)type{
    switch (type) {
        case BottomMenuTypeMood:{
            ModelViewController *mode = [ModelViewController new] ;
            [self presentWithNav:mode] ;
        }
            break;
        case BottomMenuTypePhoto:{
            PhotoViewController *photoVc = [PhotoViewController new] ;
            [self presentWithNav:photoVc] ;
        }
            break ;
        case BottomMenuTypeBlog:{
            BlogViewController *blogVc = [BlogViewController new] ;
            [self presentWithNav:blogVc] ;
        }
            break ;
        default:
            break ;
    }
}

- (void)tabbar:(Tabbar *)tabbar fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    // 取出旧的控制器的view并移除
    UIViewController *oldVc = self.childViewControllers[fromIndex] ;
    [oldVc.view removeFromSuperview] ;
    
    // 取出新的控制器,添加上去
    UIViewController *newVc = self.childViewControllers[toIndex] ;
    newVc.view.frame = self.contentView.bounds ;
    [self.contentView addSubview:newVc.view] ;
    
    // 记录之前的下标值
    self.currentIndex = toIndex ;
}

- (void)clickIconButton:(IconButton *)iconButtom{
    [self tabbar:nil fromIndex:self.currentIndex toIndex:self.childViewControllers.count - 1] ;
    [self.dock unSelected] ;
}

@end
