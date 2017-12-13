//
//  MoveableTableView.h
//  TableViewMoveDemo
//
//  Created by Silence on 2017/12/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoveableTableView;

@protocol MovableTableViewDataSource <UITableViewDataSource>

@required
/// 获取tableView的数据源数组
- (NSArray *)dataSourceArrayInTableView:(MoveableTableView *)tableView;
/// 返回移动之后调换后的数据源
- (void)tableView:(MoveableTableView *)tableView newDataSourceArrayAfterMove:(NSArray *)newDataSourceArray;

@end

@protocol MovableTableViewDelegate <UITableViewDelegate>
@optional
/// 将要开始移动indexPath位置的cell
- (void)tableView:(MoveableTableView *)tableView willMoveCellAtIndexPath:(NSIndexPath *)indexPath;
/// 完成一次从fromIndexPath cell到toIndexPath cell的移动
- (void)tableView:(MoveableTableView *)tableView didMoveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
/// 结束移动cell在indexPath
- (void)tableView:(MoveableTableView *)tableView endMoveCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MoveableTableView : UITableView


@property (nonatomic, weak) id<MovableTableViewDataSource> dataSource;
@property (nonatomic, weak) id<MovableTableViewDelegate> delegate;

/// 长按手势最小触发时间，默认1.0，最小0.2
@property (nonatomic, assign) CGFloat gestureMinimumPressDuration;
/// 自定义可移动cell的截图样式
@property (nonatomic, copy) void(^drawMovalbeCellBlock)(UIView *movableCell);

/// 是否允许拖动到屏幕边缘后，开启边缘滚动，默认YES
@property (nonatomic, assign) BOOL canEdgeScroll;
/// 边缘滚动触发范围，默认150，越靠近边缘速度越快
@property (nonatomic, assign) CGFloat edgeScrollRange;

@end
