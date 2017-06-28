//
//  CycleLoopScrollView.m
//  CycleLoopScrollViewDemo
//
//  Created by 杨晴贺 on 2017/6/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "CycleLoopScrollView.h"

#pragma mark - Categories

@implementation NSTimer (CycleLoopScrollView)

- (void)pause {
    if ([self isValid]) {
        [self setFireDate:[NSDate distantFuture]] ;
    }
}

- (void)restart {
    if ([self isValid]) {
        [self setFireDate:[NSDate date]] ;
    }
}

- (void)restartAfterTimeInterval:(NSTimeInterval)interval {
    if ([self isValid]) {
        [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]] ;
    }
}

@end

@implementation UIView (CycleLoopScrollView)

- (UIView *)copyView {
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self] ;
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive] ;
}

@end

#define DefaultAnimationDuration   0.5
@interface CycleLoopScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView ;

@property (nonatomic,strong) NSTimer *animationTimer ;
@property (nonatomic,assign) NSTimeInterval animationDuration ;

@property (nonatomic,assign) NSInteger totalPageCount ;
@property (nonatomic,assign) NSInteger currentPageIndex ;

@end

@implementation CycleLoopScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame animationScrollDuration:DefaultAnimationDuration] ;
}

- (instancetype)initWithFrame:(CGRect)frame animationScrollDuration:(NSTimeInterval)duration {
    if (self = [super initWithFrame:frame]) {
        _animationDuration = duration ;
        if (duration > 0) {
            _animationTimer = [NSTimer timerWithTimeInterval:duration
                                                      target:self
                                                    selector:@selector(startScroll:)
                                                    userInfo:nil
                                                     repeats:YES] ;
            
            NSRunLoop *mainLoop = [NSRunLoop currentRunLoop] ;
            [mainLoop addTimer:_animationTimer forMode:NSRunLoopCommonModes] ;
            [_animationTimer pause] ;
            [self addSubview:self.scrollView] ;
        }
    }
    return self ;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat height = self.frame.size.height ;
        CGFloat width = self.frame.size.width ;
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height)] ;
        _scrollView.delegate = self ;
        _scrollView.contentSize = CGSizeMake(0, height) ;
        _scrollView.pagingEnabled = YES ;
        _scrollView.showsVerticalScrollIndicator = NO ;
        _scrollView.showsHorizontalScrollIndicator = NO ;
    }
    return _scrollView ;
    
}

- (void)setDelegate:(id<CycleLoopScrollViewDelegate>)delegate {
    _delegate = delegate ;
    [self reloadData] ;
}

- (void)reloadData {
    _currentPageIndex = 0 ;
    _totalPageCount = 0 ;
    
    if ([self.delegate respondsToSelector:@selector(numberOfCountentViewInCycleLoopScrollView:)]) {
        _totalPageCount = [self.delegate numberOfCountentViewInCycleLoopScrollView:self] ;
    }else {
        NSAssert(NO, @"请实现numberOfCountentViewInCycleLoopScrollView:代理函数") ;
    }
    [self resetContentViews] ;
    [_animationTimer restartAfterTimeInterval:_animationDuration] ;
}

- (void)resetContentViews {
    // 移除scrollView上的所有子视图
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger previousPageIndex = [self getPreviousPageIndexWithCurrentPageIndex:_currentPageIndex];
    NSInteger currentPageIndex  = _currentPageIndex;
    NSInteger nextPageIndex     = [self getNextPageIndexWithCurrentPageIndex:_currentPageIndex];

    if ([self.delegate respondsToSelector:@selector(cycleLoopScrollView:contentViewAtIndex:)]) {
        
        UIView *previousContentView = [self.delegate cycleLoopScrollView:self contentViewAtIndex:previousPageIndex];
        UIView *currentContentView  = [self.delegate cycleLoopScrollView:self contentViewAtIndex:currentPageIndex];
        UIView *nextContentView     = [self.delegate cycleLoopScrollView:self contentViewAtIndex:nextPageIndex];
        
        NSArray * viewsArr = @[[previousContentView copyView],[currentContentView copyView],[nextContentView copyView]]; // copy操作主要是为了只有两张内容视图的情况
        
        for (int i = 0; i < viewsArr.count; i++) {
            UIView * contentView = viewsArr[i];
            [contentView setFrame:CGRectMake(self.frame.size.width*i, 0, contentView.frame.size.width, contentView.frame.size.height)];
            contentView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentView:)];
            [contentView addGestureRecognizer:tapGesture];
            [self.scrollView addSubview:contentView];
        }
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }else{
        NSAssert(NO, @"请实现cycleLoopScrollView:contentViewAtIndex:代理函数");
    }
}

// 获取当前页上一页的序号
- (NSInteger)getPreviousPageIndexWithCurrentPageIndex:(NSInteger)currentIndex{
    if (currentIndex == 0) {
        return _totalPageCount -1;
    }else{
        return currentIndex -1;
    }
}

// 获取当前页下一页的序号
- (NSInteger)getNextPageIndexWithCurrentPageIndex:(NSInteger)currentIndex{
    if (currentIndex == _totalPageCount -1) {
        return 0;
    }else{
        return currentIndex +1;
    }
}

- (void)startScroll:(NSTimer *)timer {
    CGFloat width = self.frame.size.width ;
    CGFloat contentOffsetX = ( (int)(_scrollView.contentOffset.x +width) / (int)width) * width;
    CGPoint newOffset = CGPointMake(contentOffsetX, 0);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)tapContentView:(UITapGestureRecognizer *)gesture{   
    if ([self.delegate respondsToSelector:@selector(cycleLoopScrollView:didSelectContentViewAtIndex:)]) {
        [self.delegate cycleLoopScrollView:self didSelectContentViewAtIndex:_currentPageIndex];
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 当手动滑动时 暂停定时器
    [_animationTimer pause];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 当手动滑动结束时 开启定时器
    [_animationTimer restartAfterTimeInterval:_animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int contentOffsetX = scrollView.contentOffset.x ;
    
    if(contentOffsetX >= (2 * self.frame.size.width)) {
        _currentPageIndex = [self getNextPageIndexWithCurrentPageIndex:_currentPageIndex];
        // 调用代理函数 当前页面序号
        if ([self.delegate respondsToSelector:@selector(cycleLoopScrollView:currentContentViewAtIndex:)]) {
            [self.delegate cycleLoopScrollView:self currentContentViewAtIndex:_currentPageIndex];
        }
        
        [self resetContentViews];
    }
    
    if(contentOffsetX <= 0) {
        _currentPageIndex = [self getPreviousPageIndexWithCurrentPageIndex:_currentPageIndex];
        // 调用代理函数 当前页面序号
        if ([self.delegate respondsToSelector:@selector(cycleLoopScrollView:currentContentViewAtIndex:)]) {
            [self.delegate cycleLoopScrollView:self currentContentViewAtIndex:_currentPageIndex];
        }
        [self resetContentViews];
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
}


@end

