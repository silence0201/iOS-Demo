//
//  SITopDisplayContent.h
//  SITopDisplay
//
//  Created by 杨晴贺 on 27/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SITopDisplayContent ;

@protocol SITopDisplayContentDataSource <NSObject>

- (NSInteger)numberOfItemInTopDisplayContent:(SITopDisplayContent *)topDisplayContent ;

- (UIView *)topDisplayContent:(SITopDisplayContent *)topDisplayContent viewForItemAtIndex:(NSInteger)index ;

- (void)topDisplayContent:(SITopDisplayContent *)topDisplayContent willScrollView:(UIView *)subview ;

- (void)selectedView:(UIView *)subView didSelectedAtIndex:(NSInteger)index ;

- (void)topDisplayContent:(SITopDisplayContent *)topDisplayContent didFinishView:(UIView *)subview ;

- (void)topDisplayContent:(SITopDisplayContent*)topDisplayContent didSelectAtIndex:(NSInteger)index;

@end

@interface SITopDisplayContent : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *contentScrollView ;

@property (nonatomic,assign) NSInteger itemCount ;

@property (nonatomic,weak,readonly) NSArray *contentSubViews ;

@property (nonatomic,strong) UIView *currentSubView ;

@property (nonatomic,assign) NSInteger selectedIndex ;

@property (nonatomic,weak) id<SITopDisplayContentDataSource> dataSource ;

@property (nonatomic,weak) id delegate ;


- (void)selectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated ;

- (void)addTarget:(id)delegate didStopScrollAction:(SEL)action ;

- (void)reloadData ;

- (void)selectedItemForIndex:(NSInteger)index animated:(BOOL)animated ;

@end
