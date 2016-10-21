//
//  SwipeTableCellTableViewCell.h
//  TableSwipeCustom
//
//  Created by 杨晴贺 on 20/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeButton.h"
#import "SwipeView.h"

typedef NS_ENUM(NSUInteger,SwipeTableViewCellStyle) {
    SwipeTableViewCellStyleRightToLeft = 0 ,  // 右滑
    SwipeTableViewCellStyleLeftToRight ,  //左滑
    SwipeTableViewCellStyleBoth // 都有
};

@protocol SwipeTableCellDelegate <NSObject>

@required
/**
 *  设置cell的滑动按钮的样式 左滑、右滑、左滑右滑都有
 *
 *  @param indexPath cell的位置
 */
- (SwipeTableViewCellStyle)tableView:(UITableView *)tableView styleOfSwipeButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  左滑cell时显示的button
 *
 *  @param indexPath cell的位置
 */
- (NSArray<SwipeButton *> *)tableView:(UITableView *)tableView leftSwipeButtonsAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  右滑cell时显示的button
 *
 *  @param indexPath cell的位置
 */
- (NSArray<SwipeButton *> *)tableView:(UITableView *)tableView rightSwipeButtonsAtIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 *  当滑动手势结束后，点击cell是否隐藏swipeView，即cell自动回复到最初状态。默认YES
 */
- (BOOL)tableView:(UITableView *)tableView hiddenSwipeViewWhenTapCellAtIndexpath:(NSIndexPath *)indexPath;

/**
 *  设置swipeView的弹出样式
 */
- (SwipeViewTransfromMode)tableView:(UITableView *)tableView swipeViewTransformModeAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SwipeTableCell : UITableViewCell

@property (nonatomic,weak) id<SwipeTableCellDelegate> swipeDelegate ;  // 代理对象
@property (nonatomic,assign) BOOL isAllowMultipSwipe ;   // 是否允许多个cell同时滑动
@property (nonatomic,assign) CGFloat swipeThreshold ;  //当结束滑动手势时,显示或显示按钮的临界值, 范围:0-1，默认0.5

@property (nonatomic,assign) SwipeViewTransfromMode transformMode ;  // swipeView的弹出效果
@property (nonatomic,assign) BOOL hideSwipeViewWhenScrollCell ;  //滚动cell是否隐藏Swipe 默认YES
@property (nonatomic,assign) BOOL isRefreshButton ;

- (void)refreshButtonsWithTitle:(NSString *)title;

@end
