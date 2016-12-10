//
//  UIViewController+EnableDrawer.m
//  DrawerDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UIViewController+EnableDrawer.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "AppDelegate.h"

@implementation UIViewController (EnableDrawer)


- (void)enableOpenLeftDrawer:(BOOL)enable{
    if (enable) {
        // 打开
        if(!ShareApp.drawerController.leftDrawerViewController){
            UINavigationController *leftNav = [[UINavigationController alloc]initWithRootViewController:[LeftViewController new]] ;
            [ShareApp.drawerController setLeftDrawerViewController:leftNav] ;
        }
    }else{
        [ShareApp.drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [ShareApp.drawerController setLeftDrawerViewController:nil] ;
        }] ;
    }
}

- (void)enableOpenRightDrawer:(BOOL)enable{
    if (enable) {
        if (!ShareApp.drawerController.rightDrawerViewController) {
            RightViewController *rightVc = [[RightViewController alloc]init] ;
            [ShareApp.drawerController setRightDrawerViewController:rightVc] ;
        }
    }else{
        [ShareApp.drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [ShareApp.drawerController setRightDrawerViewController:nil] ;
        }] ;
    }
}

@end
