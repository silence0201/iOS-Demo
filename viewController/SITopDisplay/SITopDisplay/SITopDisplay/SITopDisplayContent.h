//
//  SITopDisplayContent.h
//  SITopDisplay
//
//  Created by 杨晴贺 on 27/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SITopDisplayContent ;

#pragma mark -- SITopDisplayContentDataSource
@protocol SITopDisplayContentDataSource <NSObject>

@required
/** 内容有多少项 */
- (NSInteger)numberOfItemInTopDisplayContent:(SITopDisplayContent *)topDisplayContent ;

/** 对应视图索引有什么 */
- (UIView *)topDisplayContent:(SITopDisplayContent *)topDisplayContent viewForItemAtIndex:(NSInteger)index ;

@optional
/** 将开始滚动子视图 */
- (void)topDisplayContent:(SITopDisplayContent *)topDisplayContent willScrollView:(UIView *)subview ;

/** 用任何方式滚动子视图 */
- (void)selectedView:(UIView *)subView didSelectedAtIndex:(NSInteger)index ;

/** 结束滚动子视图 */
- (void)topDisplayContent:(SITopDisplayContent *)topDisplayContent didFinishView:(UIView *)subview ;

/** 当选中子视图 */
- (void)topDisplayContent:(SITopDisplayContent*)topDisplayContent didSelectAtIndex:(NSInteger)index;

@end

@interface SITopDisplayContent : UIView<UIScrollViewDelegate>

/** subViews */
@property (nonatomic,weak,readonly) NSArray *contentSubViews ;

/** 当前subview */
@property (nonatomic,strong) UIView *currentSubView ;

/** 当然选择的index */
@property (nonatomic,assign) NSInteger selectedIndex ;

@property (nonatomic,weak) id<SITopDisplayContentDataSource> dataSource ;


/** 通知Control变化 */
@property (nonatomic,weak) id delegate ;


- (void)reloadData ;
- (void)selectedItemForIndex:(NSInteger)index animated:(BOOL)animated ;

@end
