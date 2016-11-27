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

- (NSInteger)numberOfItemInTopDisplay:(SITopDisplay *)topDisplay ;

- (CGFloat)widthForItemInTopDisplay:(SITopDisplay *)topDisplay index:(NSInteger)index ;

- (NSString *)topDisplayControl:(SITopDisplayControl *)topDisplayControl titleForItemAtIndex:(NSInteger)index ;

- (UIView *)topDisplayContent:(SITopDisplayContent *)topDisplayContent viewForItemAtIndex:(NSInteger)index ;

@end

@protocol SITopDisplayDelegate <NSObject>

@optional

- (void)selectedView:(UIView *)subview didSelectedAtIndex:(NSInteger)index ;

- (void)topDisplayControl:(SITopDisplayControl *)topDisplayControl didSelectedAtIndex:(NSInteger)index ;

- (void)topDisplayContent:(SITopDisplayContent *)topDisplayContent didSelectAtIndex:(NSInteger)index ;


@end

@interface SITopDisplay : UIView<SITopDisplayContentDataSource,SITopDisplayControlDataSource>

@property (nonatomic,strong,readonly) SITopDisplayControl *topDisplayControl ;
@property (nonatomic,strong,readonly) SITopDisplayContent *topDisplayContent ;

@property (nonatomic,weak) id<SITopDisplayDataSource> dataSource ;
@property (nonatomic,weak) id<SITopDisplayDelegate> delegate ;

@property (nonatomic,assign) NSInteger selectedIndex ;

@property (nonatomic,strong) UIFont *titleFont ;

@property (nonatomic,strong) UIColor *selectedColor ;
@property (nonatomic,strong) UIColor *normalColor ;

@property (nonatomic,strong) UIImage *selectedBackgroundImage ;
@property (nonatomic,strong) UIImage *unSelectedBackgroundImage ;

@property (nonatomic,strong) UIColor *moveViewColor ;
@property (nonatomic,strong) UIColor *dividLineColor ;

- (instancetype)initWithFrame:(CGRect)frame withControl:(BOOL)haveControl ;
- (instancetype)initWithFrame:(CGRect)frame topFrame:(CGRect)topFrame ;

@end
