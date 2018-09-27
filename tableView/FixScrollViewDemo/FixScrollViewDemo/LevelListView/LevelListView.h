//
//  LevelListView.h
//  FixScrollViewDemo
//
//  Created by Silence on 2018/9/27.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "LevelListViewConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelListContainView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleImageView;

@end

@class LevelListView;

@protocol LevelListViewDelegate <NSObject>

- (void)levelListView:(LevelListView *)levelListView chooseIndex:(NSInteger)index;

@end

@interface LevelListView : UIView

@property (nonatomic,weak) id<LevelListViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame config:(LevelListViewConfig *)config;

@property (nonatomic,strong) LevelListViewConfig *config;
@property (nonatomic,assign) NSInteger selectedIndex;

- (void)traverseAllSubView:(void(^)(LevelListContainView *subView, NSInteger idx))block;
- (void)configAnimationOffsetX:(CGFloat)offsetX;


@end

NS_ASSUME_NONNULL_END
