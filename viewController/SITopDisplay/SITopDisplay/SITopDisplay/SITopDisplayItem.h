//
//  SITopDisplayItem.h
//  SITopDisplay
//
//  Created by 杨晴贺 on 27/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SITopDisplayItem ;
@protocol  SITopDisplayItemDelegate<NSObject>
@required
- (void)didSelectedOnItem:(SITopDisplayItem *)item ;

@end

@interface SITopDisplayItem : UIView

/** 当前item的index */
@property (nonatomic,assign) NSInteger index ;

/** 标题Label */
@property (nonatomic,strong) UILabel *titleLabel ;

/** 标题的字体 */
@property (nonatomic,strong) UIFont *titleFont ;

/** 是否放大选中的title */
@property (nonatomic,assign) BOOL amplifySelectedTitle ;

/** 选中字体的颜色 */
@property (nonatomic,strong) UIColor *selectedColor ;

/** 正常字体的颜色 */
@property (nonatomic,strong) UIColor *normalColor ;

/** 选择后的背景图片 */
@property (nonatomic,strong) UIImage *selectedBackgroundImage ;

/** 没有选择的背景图片 */
@property (nonatomic,strong) UIImage *unSelectedBackgroundImage ;

/** 背景图片View */
@property (nonatomic,strong) UIImageView *backgroundImageView ;

/**代理 */
@property (nonatomic,strong) id<SITopDisplayItemDelegate> delegate ;

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title defaultBackgroundImage:(UIImage *)backgroundImage ;

/** 切换到选中状态 */
- (void)switchToSelected ;

/** 切换到征程状态 */
- (void)switchToNormal ;

@end
