//
//  SITabBarViewController.m
//  TabbarDemo
//
//  Created by 杨晴贺 on 9/11/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SITabBarViewController.h"
#import "SINavigationController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "SITabBar.h"

@interface SITabBarViewController ()

/*自定义Tabbar*/
@property (nonatomic,strong) SITabBar *customTabBar ;

@end

@implementation SITabBarViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupControllersWithClass:[OneViewController class]
                              title:@"one"
                              image:@"tab_discover_normal"
                       seletedImage:@"tab_discover_selected"
                            NibName:nil] ;
    
    [self setupControllersWithClass:[TwoViewController class]
                              title:@"Two"
                              image:@"tab_me_normal"
                       seletedImage:@"tab_me_selected"
                            NibName:nil];
    
    [self setupControllersWithClass:[ThreeViewController class]
                              title:@"three"
                              image:@"tab_me_normal"
                       seletedImage:@"tab_me_selected"
                            NibName:nil];
    
    
    [self setupControllersWithClass:[FourViewController class]
                              title:@"Four"
                              image:@"tab_me_normal"
                       seletedImage:@"tab_me_selected"
                            NibName:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    
    if (_customTabBar == nil) {
        // 移除原来的系统空间
        for (UIView *view in self.tabBar.subviews) {
            [view removeFromSuperview] ;
        }
        
        __weak typeof (self) weakSelf = self ;
        
        _customTabBar = [[SITabBar alloc]initWithFrame:self.tabBar.bounds] ;
        _customTabBar.controllers = self.childViewControllers ;
        
        SITabBarButton *tabBtn = [self.customTabBar.items objectAtIndex:0];
        tabBtn.badgeStyle = TabItemBadgeStyleNumber;
        tabBtn.badge = 9;
        
        SITabBarButton *tabBtn1 = [self.customTabBar.items objectAtIndex:1];
        tabBtn1.badgeStyle = TabItemBadgeStyleNumber;
        tabBtn1.badge = 999;
        
        SITabBarButton *tabBtn2 = [self.customTabBar.items objectAtIndex:2];
        tabBtn2.badgeStyle = TabItemBadgeStyleNumber;
        tabBtn2.badge = 66;
        
        SITabBarButton *tabBtn3 = [self.customTabBar.items objectAtIndex:3];
        tabBtn3.badgeStyle = TabItemBadgeStyleDot;
        
        _customTabBar.clickBlock = ^(NSInteger index){
            weakSelf.selectedIndex = index ;
        } ;
        
        [self.tabBar addSubview:_customTabBar] ;
    }
}

#pragma mark - Private Method
//设置标签控制器上内容
- (void)setupControllersWithClass:(Class)class
                            title:(NSString *)title
                            image:(NSString*)imageStr
                     seletedImage:(NSString *)selectedImage
                          NibName:(NSString *)name{
    
    //创建子导航控制器、Controller控制器
    UIViewController *vc = [[class alloc] initWithNibName:name bundle:nil];
    SINavigationController *na = [[SINavigationController alloc]initWithRootViewController:vc];
    vc.navigationItem.title = title;
    na.tabBarItem.title = title;
    na.tabBarItem.image = [[UIImage imageNamed:imageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    na.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:na];
}


@end
