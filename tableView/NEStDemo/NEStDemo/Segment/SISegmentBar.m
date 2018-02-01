//
//  SISegmentBar.m
//  NEStDemo
//
//  Created by Silence on 2018/2/1.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "SISegmentBar.h"

CGFloat const btnMinWidth = 80.f;

@interface SISegmentBar()

@property (nonatomic,strong) UIScrollView *btnScroll;
@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,weak)   UIButton *lastBtn ;

@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,strong) UIColor *selectedColor;

@end


@implementation SISegmentBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles selectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor {
    if (self = [super init]) {
        self.selectedColor = selectedColor;
        self.normalColor = normalColor;
        
        self.titles = titles;
    
        
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    UIColor *selectedColor = [UIColor colorWithRed:42/255.0 green:184/255.0 blue:104/255.0 alpha:1.0];
    UIColor *normalColor = [UIColor darkGrayColor];
    return [[[self class]alloc]initWithTitles:titles selectedColor:selectedColor normalColor:normalColor];
}


- (void)setupUI {
    [self addSubview:self.indicatorView];
    [self addSubview:self.btnScroll];
}

- (UIScrollView *)btnScroll {
    if (!_btnScroll) {
        _btnScroll = [[UIScrollView alloc]init];
        _btnScroll.showsVerticalScrollIndicator = NO;
        _btnScroll.showsHorizontalScrollIndicator = NO;
    }
    return _btnScroll;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]init];
    }
    return _indicatorView;
}

- (NSMutableArray *)btns {
    if (!_btns){
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.bounds.size.width>0) {
        if ([self.superview isKindOfClass:[UINavigationBar class]]) {
            CGFloat navTitleViewMargin = [UIScreen mainScreen].scale > 2.1 ? 12 :8;
            self.btnScroll.frame = CGRectMake(-navTitleViewMargin, 0, self.bounds.size.width+navTitleViewMargin*2, self.bounds.size.height);
        } else {
            self.btnScroll.frame = self.bounds;
        }
        
        if (self.btns.count > 0) {
            CGFloat labelW = self.btnScroll.bounds.size.width/self.btns.count > btnMinWidth ?self.btnScroll.bounds.size.width/self.btns.count: btnMinWidth;
            CGFloat labelY = 0;
            CGFloat labelH = self.btnScroll.bounds.size.height;
            for (int i = 0; i < self.btns.count; i++) {
                UIButton *btn = self.btns[i];
                CGFloat labelX = i * labelW;
                btn.frame = CGRectMake(labelX, labelY, labelW, labelH);
            }
            self.btnScroll.contentSize = CGSizeMake(self.btns.count * labelW, 0);
        }
        
        self.lastBtn = self.lastBtn ?: self.btns.firstObject;
        
        [self updateIndicatorFrame];
    }
}

// 刷新横线的位置
- (void)updateIndicatorFrame {
    NSString *text = self.lastBtn.titleLabel.text;
    self.indicatorView.backgroundColor = [self.lastBtn titleColorForState:UIControlStateSelected];
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName : self.lastBtn.titleLabel.font}];
    CGFloat indicatorW = size.width + 20;
    CGFloat indicatorH = 1.5;
    CGFloat indicatorY = self.btnScroll.bounds.size.height - indicatorH;
    self.indicatorView.frame = CGRectMake(0, indicatorY, indicatorW, indicatorH);
    CGPoint center = self.indicatorView.center;
    center.x = self.lastBtn.center.x;
    self.indicatorView.center = center;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    if (titles.count > 0) {
        for (NSInteger i = 0 ; i < titles.count ; i++){
            NSString *title =titles[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
            [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.tag = i;
            [self.btnScroll addSubview:btn];
            [self.btns addObject:btn];
        }
    }
    
    [self layoutIfNeeded];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self changeMenuScrollOffset:selectedIndex];
}


- (void)changeMenuScrollOffset:(NSInteger)index{
    // 让对应的顶部标题居中显示
    UIButton *btn = self.btnScroll.subviews[index];
    if (self.btnScroll.contentSize.width > self.btnScroll.bounds.size.width) {
        CGPoint titleOffset = self.btnScroll.contentOffset;
        titleOffset.x = btn.center.x - self.bounds.size.width * 0.5;
        // 左边超出处理
        if (titleOffset.x < 0) titleOffset.x = 0;
        // 右边超出处理
        CGFloat maxTitleOffsetX = self.btnScroll.contentSize.width - self.bounds.size.width;
        if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
        
        [self.btnScroll setContentOffset:titleOffset animated:YES];
    }
    // 修改选中状态
    self.lastBtn.selected = NO;
    btn.selected = YES;
    self.lastBtn = btn;
    
    // 移动横线位置
    if (CGRectEqualToRect(self.indicatorView.frame, CGRectZero)) {
        [self updateIndicatorFrame];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            [self updateIndicatorFrame];
        }];
    }
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)tap {
    NSInteger index = tap.tag;
    [self changeMenuScrollOffset:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:selectedIndex:)]) {
        [self.delegate segmentBar:self selectedIndex:tap.tag];
    }
}

@end
