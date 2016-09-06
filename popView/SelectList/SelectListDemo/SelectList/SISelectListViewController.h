//
//  SISelectListViewController.h
//  SelectListDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SISelectListItem ;

typedef void(^SelectListClickBlock)(NSInteger selectIndex);
@interface SISelectListViewController : UIViewController

/**
 *  数据源对象
 */
@property (nonatomic,strong) NSArray<SISelectListItem *> *items ;

/**
 *  在哪个viewController显示
 */
@property (nonatomic,strong) UIViewController *showListViewController ;

/**
 *  点击回调
 */
@property (nonatomic,copy) SelectListClickBlock clickBlock ;

/**
 *  背景透明度
 */
@property (nonatomic,assign) CGFloat alphaComponent ;

/**
 *  背景图片
 */
@property (nonatomic,copy) NSString *backgroudName ;

/**
 *  快速构造函数
 *
 *  @param items 数据源对象
 *
 *  @return viewController
 */
- (instancetype)initWithItem:(NSArray <SISelectListItem *> *)items ;

/**
 *  显示弹框
 */
- (void)show ;

/**
 *  隐藏弹框
 *
 *  @param animated 是否有动画
 */
- (void)dismissWithAnimate:(BOOL)animated ;

@end
