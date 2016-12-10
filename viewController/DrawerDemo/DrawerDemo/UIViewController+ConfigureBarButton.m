//
//  UIViewController+ConfigureBarButton.m
//  DrawerDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UIViewController+ConfigureBarButton.h"
#import <objc/runtime.h>

static const void *viewControllerRightBarButtonAction = &viewControllerRightBarButtonAction ;
static const void *viewControllerLeftBarButtonAction = &viewControllerLeftBarButtonAction ;

@interface UIViewController ()

@property (nonatomic,copy) ButtonActionBlock rightBarButtonAction ;
@property (nonatomic,copy) ButtonActionBlock leftBarButtonAction ;

@end

@implementation UIViewController (ConfigureBarButton)

#pragma mark --- get/set
- (void)setRightBarButtonAction:(ButtonActionBlock)rightBarButtonAction{
    objc_setAssociatedObject(self, viewControllerRightBarButtonAction, rightBarButtonAction, OBJC_ASSOCIATION_COPY) ;
}

- (ButtonActionBlock)rightBarButtonAction{
    return objc_getAssociatedObject(self, viewControllerRightBarButtonAction) ;
}

- (void)setLeftBarButtonAction:(ButtonActionBlock)leftBarButtonAction{
    objc_setAssociatedObject(self, viewControllerLeftBarButtonAction, leftBarButtonAction, OBJC_ASSOCIATION_COPY) ;
}

- (ButtonActionBlock)leftBarButtonAction{
    return objc_getAssociatedObject(self, viewControllerLeftBarButtonAction) ;
}

#pragma mark --- Action
- (void)clickedLeftBarButtonItemAction{
    if (self.leftBarButtonAction) {
        self.leftBarButtonAction();
    }
}

- (void)clickedRightBarButtonItemAction{
    if (self.rightBarButtonAction) {
        self.rightBarButtonAction();
    }
}

#pragma mark -- Public Method
- (void)configureLeftBarButtonWithTitle:(NSString *)title action:(ButtonActionBlock)action{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 40, 30);
    [leftBtn addTarget:self action:@selector(clickedLeftBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:title forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *navLeftBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem =navLeftBtn;
    
    self.leftBarButtonAction = action;
}

- (void)configureRightBarButtonWithTitle:(NSString *)title action:(ButtonActionBlock)action{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn addTarget:self action:@selector(clickedRightBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem =navRightBtn;
    
    self.rightBarButtonAction = action;
}

@end
