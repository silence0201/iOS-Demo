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
@protocol SITopDisplayControlDataSource <NSObject>

/** 菜单里面有多少项 */
- (NSInteger)numberOfItemInTopDisplayControl:(SITopDisplayControl *)topDisplayControl ;

/** 对应索引项得标题是什么 */
- (NSString *)topDisplayControl:(SITopDisplayControl *)topDisplayControl titleForItemAtIndex:(NSInteger)index ;

/** 每一项的宽度是多少 */
- (CGFloat)widthForItemInTopDisplayControl:(SITopDisplayControl *)topDisplayControl index:(NSInteger)index ;


/** 菜单选中某项  */
- (void)topDisplayControl:(SITopDisplayControl *)topDisplayControl didSelectedAtIndex:(NSInteger)index ;

/** 菜单将选中某项 */
- (void)topDisplayControl:(SITopDisplayControl *)topDisplayControl willSelectedAtIndex:(NSInteger)index ;

@end

@interface SITopDisplayControl : UIView<SITopDisplayItemDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *backScrollView ;

@property (nonatomic,assign) NSInteger lastSelectedIndex ;

@property (nonatomic,assign) NSInteger itemsCount ;

@property (nonatomic,strong) UIView *bottomView ;

@property (nonatomic,strong) UIImageView *moveImageView ;

@property (nonatomic,strong) UIFont *titleFont;

@property (nonatomic,assign) BOOL amplifySelectedTitle ;

@property (nonatomic,strong) UIImage *itemBackgroundImageLeft ;

@property (nonatomic,strong) UIImage *itemBackgroundImageRight ;

@property (nonatomic,strong) UIImage *itemBackgroundImageMiddle ;

@property (nonatomic,strong) UIColor *moveViewColor ;

@property (nonatomic,strong) UIColor *dividLineColor ;

@property (nonatomic,strong) UIColor *selectedColor ;

@property (nonatomic,strong) UIColor *normalColor ;

@property (nonatomic,strong) UIImage *selectedBackgroundImage ;

@property (nonatomic,strong) UIImage *unSelectedBackgroundImage ;

@property (nonatomic,weak) id<SITopDisplayControlDataSource> dataSource;

@property (nonatomic,weak) id delegate ;

- (SITopDisplayItem *)itemForIndex:(NSInteger)index ;

- (void)selectedItemForIndex:(NSInteger)index animated:(BOOL)animaled ; 

@end
