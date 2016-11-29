//
//  SITopDisplay.h
//  SITopDisplay
//
//  Created by 杨晴贺 on 27/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SITopDisplayContent.h"
#import "SITopDisplayControl.h"

@class SITopDisplay ;
@protocol SITopDisplayDataSource <NSObject>

@required
/** 有多少项 */
- (NSInteger)numberOfItemInTopDisplay:(SITopDisplay *)topDisplay ;

/** 每一项的宽度 */
- (CGFloat)widthForItemInTopDisplay:(SITopDisplayControl *)topDisplayControl index:(NSInteger)index ;

/** 对应项的标题 */
- (NSString *)topDisplayControl:(SITopDisplayControl *)topDisplayControl titleForItemAtIndex:(NSInteger)index ;

/** 对应项对应的View */
- (UIView *)topDisplayContent:(SITopDisplayContent *)topDisplayContent viewForItemAtIndex:(NSInteger)index ;

@end

@protocol SITopDisplayDelegate <NSObject>

@optional
/** 当选中对应项时 */
- (void)selectedView:(UIView *)subview didSelectedAtIndex:(NSInteger)index ;

/** 选择对应标题 */
- (void)topDisplayControl:(SITopDisplayControl *)topDisplayControl didSelectedAtIndex:(NSInteger)index ;

/** 滚动选中对应项时 */
- (void)topDisplayContent:(SITopDisplayContent *)topDisplayContent didSelectedAtIndex:(NSInteger)index ;

@end

@interface SITopDisplay : UIView<SITopDisplayContentDataSource,SITopDisplayControlDataSource>


/** 顶部切换控制View */
@property (nonatomic,strong,readonly) SITopDisplayControl *topDisplayControl ;

/** 主要内容View */
@property (nonatomic,strong,readonly) SITopDisplayContent *topDisplayContent ;

/** 数据员 */
@property (nonatomic,weak) id<SITopDisplayDataSource> dataSource ;

/** 代理 */
@property (nonatomic,weak) id<SITopDisplayDelegate> delegate ;

/** 当前选中 */
@property (nonatomic,assign) NSInteger selectedIndex ;

/** 标题的字体 */
@property (nonatomic,strong) UIFont *titleFont ;

/** 选中的颜色 */
@property (nonatomic,strong) UIColor *selectedColor ;

/** 普通状态颜色 */
@property (nonatomic,strong) UIColor *normalColor ;

/** 选中背景 */
@property (nonatomic,strong) UIImage *selectedBackgroundImage ;

/** 未选中背景 */
@property (nonatomic,strong) UIImage *unSelectedBackgroundImage ;

/** 移动线的颜色 */
@property (nonatomic,strong) UIColor *moveViewColor ;

/** 分割线的颜色 */
@property (nonatomic,strong) UIColor *dividLineColor ;

- (instancetype)initWithFrame:(CGRect)frame withControl:(BOOL)haveControl ;
- (instancetype)initWithFrame:(CGRect)frame topFrame:(CGRect)topFrame ;

@end
