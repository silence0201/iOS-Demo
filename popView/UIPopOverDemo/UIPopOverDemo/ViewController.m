//
//  ViewController.m
//  UIPopOverDemo
//
//  Created by 杨晴贺 on 31/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "OtherViewController.h"

@interface ViewController ()<UIPopoverPresentationControllerDelegate>{
    UIButton *_popOverButton ;
    UIBarButtonItem *_rightBarButtonItem ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    [self loadBarButtonItem] ;
    
    [self loadButton] ;
}

- (void)loadBarButtonItem{
    _rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Click" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClickAction)] ;
    self.navigationItem.rightBarButtonItem = _rightBarButtonItem ;
}

- (void)loadButton{
    _popOverButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)] ;
    _popOverButton.center = self.view.center;
    _popOverButton.backgroundColor = [UIColor orangeColor] ;
    [_popOverButton setTitle:@"Click" forState:UIControlStateNormal] ;
    [_popOverButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:_popOverButton] ;
    
}

- (void)rightBarButtonClickAction{
    OtherViewController *otherVc = [[OtherViewController alloc]init] ;
    otherVc.modalPresentationStyle = UIModalPresentationPopover ;
    // 导航栏上的空间没有指定的frame,所以无法设置sourceView和sourceRect,用下面设置
    otherVc.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem ;
    otherVc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp ;
    otherVc.popoverPresentationController.delegate = self ;
    // 设置页面大小
    otherVc.preferredContentSize = CGSizeMake(150, 200) ;
    [self presentViewController:otherVc animated:YES completion:nil] ;
}

- (void)buttonAction{
    OtherViewController *otherVc = [[OtherViewController alloc]init] ;
    otherVc.modalPresentationStyle = UIModalPresentationPopover ;
    otherVc.popoverPresentationController.sourceView = _popOverButton ;  // rect参数是以view的左上角为坐标原点（0，0）
    otherVc.popoverPresentationController.sourceRect = _popOverButton.bounds ; // //指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
    otherVc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp ;  ////箭头方向
    otherVc.popoverPresentationController.delegate = self;
    // 设置页面大小
    otherVc.preferredContentSize = CGSizeMake(150, 200) ;
    [self presentViewController:otherVc animated:YES completion:nil] ;
}

#pragma mark -- UIPopoverPresentationControllerDelegate
//iPhone下默认是UIModalPresentationFullScreen，需要手动设置为UIModalPresentationNone，iPad不需要
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}
- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller.presentedViewController];
    return navController;
}
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;   //点击蒙板popover不消失， 默认yes
}

@end
