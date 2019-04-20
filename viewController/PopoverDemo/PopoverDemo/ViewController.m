//
//  ViewController.m
//  PopoverDemo
//
//  Created by Silence on 2019/4/20.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "PopoverViewController.h"

@interface ViewController ()<UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) PopoverViewController *buttonPopVC;
@property (strong, nonatomic) PopoverViewController *itemPopVC;

@end

@implementation ViewController

- (IBAction)rightBarItemClick:(UIBarButtonItem *)barItem {
    self.itemPopVC.popoverPresentationController.barButtonItem = barItem;
    self.itemPopVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    self.itemPopVC.popoverPresentationController.delegate  = self;
    [self presentViewController:self.itemPopVC animated:YES completion:nil];
    
}
- (IBAction)buttonClick:(UIButton *)btn {
    self.buttonPopVC.popoverPresentationController.sourceView = btn; //rect参数是以view的左上角为坐标原点（0，0）
    self.buttonPopVC.popoverPresentationController.sourceRect = btn.bounds; //指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
    self.buttonPopVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    self.buttonPopVC.popoverPresentationController.delegate  = self;
    [self presentViewController:self.buttonPopVC animated:YES completion:nil];
}

- (PopoverViewController *)buttonPopVC {
    if (!_buttonPopVC) {
        _buttonPopVC = [[PopoverViewController alloc]init];
        _buttonPopVC.modalPresentationStyle = UIModalPresentationPopover;
    }
    return _buttonPopVC;
}

- (PopoverViewController *)itemPopVC {
    if (!_itemPopVC) {
        _itemPopVC = [[PopoverViewController alloc]init];
        _itemPopVC.modalPresentationStyle = UIModalPresentationPopover;
    }
    return _itemPopVC;
}

#pragma mark -- Delegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;   //点击蒙版popover消失， 默认yes
}

@end
