//
//  SITopDisplayContent.m
//  SITopDisplay
//
//  Created by 杨晴贺 on 27/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SITopDisplayContent.h"

#pragma mark -- SITopDisplayScrollView
@interface SITopDisplayScrollView : UIScrollView
@end

@implementation SITopDisplayScrollView

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer translationInView:self];
    if(self.contentOffset.x == 0 && point.x > 0){
        return NO;
    }
    if(self.contentOffset.x == (self.contentSize.width - self.frame.size.width) && point.x < 0){
        return NO;
    }
    return YES;
}

@end

#pragma mark -- SITopDisplayContent
@interface SITopDisplayContent ()

/** 容器ScrollView */
@property (nonatomic,strong) UIScrollView *contentScrollView ;

/** 一共有多少项 */
@property (nonatomic,assign) NSInteger itemCount ;

@end

@implementation SITopDisplayContent

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentScrollView = [[SITopDisplayScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] ;
        self.contentScrollView.pagingEnabled = YES ;
        self.contentScrollView.delegate = self ;
        self.contentScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth ;
        self.contentScrollView.showsVerticalScrollIndicator = NO ;
        [self addSubview:self.contentScrollView] ;
    }
    return self ;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect] ;
    [self reloadData] ;
}

#pragma mark -- Selected Private Method
- (void)selectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated{
    if (selectedIndex != _selectedIndex) {
        _selectedIndex = selectedIndex ;
        [self selectedItem:animated] ;
    }
}

- (void)selectedItem:(BOOL)animated{
    if (self.itemCount > 0) {
        if (self.selectedIndex == self.itemCount) {
            self.selectedIndex = self.itemCount - 1 ;
        }
        [self viewOfselected:self.selectedIndex animal:animated] ;
    }
}

- (void)viewOfselected:(NSInteger)index animal:(BOOL)animal{
    if (self.currentSubView) {
        if ([self.dataSource respondsToSelector:@selector(topDisplayContent:didFinishView:)]) {
            [self.dataSource topDisplayContent:self didFinishView:self.currentSubView] ;
        }
    }
    
    if([self.dataSource respondsToSelector:@selector(selectedView:didSelectedAtIndex:)]){
        UIView *subView = [self.contentScrollView.subviews objectAtIndex:index] ;
        self.currentSubView = subView ;
        [self.dataSource selectedView:subView didSelectedAtIndex:index] ;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectedItemForIndex:animated:)]) {
        [self.delegate selectedItemForIndex:index animated:animal] ;
    }
}

#pragma mark -- Public Method 
- (void)selectedItemForIndex:(NSInteger)index animated:(BOOL)animated{
    if(index < self.itemCount){
        if (animated) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationRepeatAutoreverses:NO];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationDelegate:self];
        }
        CGPoint pointoffset=CGPointMake(index*self.contentScrollView.frame.size.width, 0);
        self.contentScrollView.contentOffset=pointoffset;
        if (animated) {
            [UIView commitAnimations];
        }
        [self viewOfselected:index animal:animated];
    }
}

#pragma mark -- load data 
- (void)reloadData{
    NSAssert(self.dataSource, @"DataSource can't be nil") ;
    self.itemCount = 0 ;
    
    NSAssert([self.dataSource respondsToSelector:@selector(numberOfItemInTopDisplayContent:)], @"DataSource must can response numberOfItemInTopDisplayContent method") ;
    if([self.dataSource respondsToSelector:@selector(numberOfItemInTopDisplayContent:)]){
        self.itemCount = [self.dataSource numberOfItemInTopDisplayContent:self] ;
    }
    
    // 清空子视图
    for(UIView *subview in self.contentScrollView.subviews){
        [subview removeFromSuperview] ;
    }
    
    // 加载子视图
    CGRect frame = self.contentScrollView.frame ;
    NSAssert([self.dataSource respondsToSelector:@selector(topDisplayContent:viewForItemAtIndex:)], @"DataSource must can response topDisplayContent:viewForItemAtIndex: method") ;
    if ([self.dataSource respondsToSelector:@selector(topDisplayContent:viewForItemAtIndex:)]) {
        for (NSInteger i =0 ; i < self.itemCount; i++) {
            UIView *subview = [self.dataSource topDisplayContent:self viewForItemAtIndex:i];
            frame.origin.x = frame.size.width * i;
            frame.origin.y = 0;
            subview.frame = frame;
            [self.contentScrollView addSubview:subview];
        }
    }
    
    [self selectedItem:NO] ;
    [self.contentScrollView setContentSize:CGSizeMake(frame.size.width*self.itemCount, frame.size.height)] ;
}

#pragma mark -- set/get
- (NSArray *)contentSubViews{
    return self.contentScrollView.subviews ;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    [self selectedIndex:selectedIndex animated:YES] ;
}

#pragma mark -- UIScrollViewDelegate
// 视图将要开始滑动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if([self.dataSource respondsToSelector:@selector(topDisplayContent:willScrollView:)]){
        [self.dataSource topDisplayContent:self willScrollView:self.currentSubView] ;
    }
}
// 选择某个子视图
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point= scrollView.contentOffset;
    NSInteger i=point.x/scrollView.frame.size.width;
    if([self.dataSource respondsToSelector:@selector(topDisplayContent:didSelectAtIndex:)]){
        [self.dataSource topDisplayContent:self didSelectAtIndex:i];
    }
    _selectedIndex = i;
    [self viewOfselected:i animal:YES];
}

@end
