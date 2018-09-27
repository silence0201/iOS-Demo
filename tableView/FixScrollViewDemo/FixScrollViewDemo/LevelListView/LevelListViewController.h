//
//  LevelListViewController.h
//  FixScrollViewDemo
//
//  Created by Silence on 2018/9/27.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "LevelListView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelListViewController : UIViewController

@property (nonatomic, strong, readonly) LevelListView *titleView;


/**
 初始化方法 （常用）
 
 @param controllers 控制器数组
 @param titleViewTitles 控制器数组对应的标题数组
 @param titleViewHeight 标题view高度
 @param contentViewHeight 内容view高度
 */
- (void)initializeWithControllers:(NSArray<UIViewController *> *)controllers titleViewTitles:(NSArray<id> *)titleViewTitles titleViewHeight:(CGFloat)titleViewHeight contentViewHeight:(CGFloat)contentViewHeight;

/**
 详细的初始化方法
 
 @param controllers --
 @param configModel 标题view配置UI的model（详细看api）
 @param titleViewHeight --
 @param contentViewHeight --
 */
- (void)initializeWithControllers:(NSArray<UIViewController *> *)controllers titleViewConfigModel:(LevelListViewConfig *)configModel titleViewHeight:(CGFloat)titleViewHeight contentViewHeight:(CGFloat)contentViewHeight;

/**
 详细的初始化方法
 
 @param controllers --
 @param configModel --
 @param titleViewFrame 标题view的frame
 @param contentViewFrame 内容view的frame
 */
- (void)initializeWithControllers:(NSArray<UIViewController *> *)controllers titleViewConfigModel:(LevelListViewConfig *)configModel titleViewFrame:(CGRect)titleViewFrame contentViewFrame:(CGRect)contentViewFrame;

/**
 动态的设置titleView的各项属性 （这里朗阔了所有titleview的配置）
 
 @param configModel 配置UI的model
 */
- (void)configTitleViewWithConfigModel:(LevelListViewConfig *)configModel;


/**
 遍历titleView的所有子视图
 
 @param block --
 */
- (void)traverseTitleViewAllSubView:(void(^)(LevelListContainView *subView, NSInteger idx))block;


/**
 是否每次滚动完成都刷新UI（确保每次Controller会走viewWillApear方法）  此方法慎用
 
 @param update --
 */
- (void)updateUIWhenScrollEnd:(BOOL)update;

@end

NS_ASSUME_NONNULL_END
