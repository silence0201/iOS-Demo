//
//  LevelListView.m
//  FixScrollViewDemo
//
//  Created by Silence on 2018/9/27.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "LevelListView.h"

static const NSInteger kConstTagOfYBLevelListSubView = 10101;

@interface LevelListContainView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleImageView;

@end

@implementation LevelListContainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleImageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark *** getter ***
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [UIImageView new];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        _titleImageView.layer.masksToBounds = YES;
    }
    return _titleImageView;
}
@end

@interface LevelListView ()

//记录子视图数组
@property (nonatomic, strong) NSMutableArray<LevelListContainView *> *subViewArr;
//记录子视图总共的长度
@property (nonatomic, assign) CGFloat totalLengthOfSubView;
//记录上一次滚动视图偏移量
@property (nonatomic, assign) CGFloat lastOffsetX;


//滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;


//选择状态下划线
@property (nonatomic, strong) UIView *underLineSelectView;
//默认下划线
@property (nonatomic, strong) UIView *underLineView;


//开始颜色,取值范围0~1
@property (nonatomic, assign) CGFloat startR;
@property (nonatomic, assign) CGFloat startG;
@property (nonatomic, assign) CGFloat startB;


//完成颜色,取值范围0~1
@property (nonatomic, assign) CGFloat endR;
@property (nonatomic, assign) CGFloat endG;
@property (nonatomic, assign) CGFloat endB;

@end

@implementation LevelListView

@end
