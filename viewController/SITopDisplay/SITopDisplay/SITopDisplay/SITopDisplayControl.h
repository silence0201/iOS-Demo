//
//  SITopDisplayControl.h
//  SITopDisplay
//
//  Created by 杨晴贺 on 27/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SITopDisplayItem.h"

@class SITopDisplayControl ;

#pragma mark --- SITopDisplayControlDataSource
@protocol SITopDisplayControlDataSource <NSObject>

@required
/** 菜单里面有多少项 */
- (NSInteger)numberOfItemInTopDisplayControl:(SITopDisplayControl *)topDisplayControl ;

/** 对应索引项得标题是什么 */
- (NSString *)topDisplayControl:(SITopDisplayControl *)topDisplayControl titleForItemAtIndex:(NSInteger)index ;

/** 每一项的宽度是多少 */
- (CGFloat)widthForItemInTopDisplayControl:(SITopDisplayControl *)topDisplayControl index:(NSInteger)index ;

@optional
/** 菜单选中某项  */
- (void)topDisplayControl:(SITopDisplayControl *)topDisplayControl didSelectedAtIndex:(NSInteger)index ;

/** 菜单将选中某项 */
- (void)topDisplayControl:(SITopDisplayControl *)topDisplayControl willSelectedAtIndex:(NSInteger)index ;

@end

#pragma mark --- SITopDisplayControl
@interface SITopDisplayControl : UIView<SITopDisplayItemDelegate>

/** 字体字体 */
@property (nonatomic,strong) UIFont *titleFont;

/** 选择的字体是否变大 */
@property (nonatomic,assign) BOOL amplifySelectedTitle ;


/** 选择项的背景颜色 */
@property (nonatomic,strong) UIImage *itemBackgroundImageLeft ;
@property (nonatomic,strong) UIImage *itemBackgroundImageMiddle ;
@property (nonatomic,strong) UIImage *itemBackgroundImageRight ;

/** 移动View的颜色 */
@property (nonatomic,strong) UIColor *moveViewColor ;

/** 分隔线的颜色 */
@property (nonatomic,strong) UIColor *dividLineColor ;

/** 选中的颜色 */
@property (nonatomic,strong) UIColor *selectedColor ;

/** 普通的颜色 */
@property (nonatomic,strong) UIColor *normalColor ;

/** 选中的背景 */
@property (nonatomic,strong) UIImage *selectedBackgroundImage ;

/** 未选中的背景 */
@property (nonatomic,strong) UIImage *unSelectedBackgroundImage ;

@property (nonatomic,weak) id<SITopDisplayControlDataSource> dataSource;


/** 通知Content进行变化的代理 */
@property (nonatomic,weak) id delegate ;

- (SITopDisplayItem *)itemForIndex:(NSInteger)index ;
- (void)selectedItemForIndex:(NSInteger)index animated:(BOOL)animaled ; 

@end
