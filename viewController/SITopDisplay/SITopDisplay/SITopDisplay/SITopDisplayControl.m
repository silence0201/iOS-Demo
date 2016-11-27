//
//  SITopDisplayControl.m
//  SITopDisplay
//
//  Created by 杨晴贺 on 27/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SITopDisplayControl.h"

#define DEFAULT_ITEM_WIDTH 60

@implementation SITopDisplayControl{
    NSInteger willSelctedIndex ;
    NSInteger selectedIndex ;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        willSelctedIndex = 0 ;
        
        // 设置ScrollView
        self.backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] ;
        self.backScrollView.showsHorizontalScrollIndicator = NO ;
        self.backScrollView.delegate = self ;
        [self addSubview:self.backScrollView] ;
        
        // 设置分割线
        self.dividLineColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2] ;
        self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)] ;
        self.bottomView.backgroundColor = self.dividLineColor ;
        self.bottomView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin ;
        [self addSubview:self.bottomView] ;
    }
    return self ;
}

- (void)setDividLineColor:(UIColor *)dividLineColor{
    _dividLineColor = dividLineColor ;
    if(_dividLineColor){
        self.bottomView .backgroundColor = _dividLineColor ;
        [self setNeedsLayout] ;
    }
}

#pragma mark -- reload data
- (void)reloadData{
    for(UIView *subView in self.backScrollView.subviews){
        if(subView == self.moveImageView){
            continue ;
        }
        [subView removeFromSuperview] ;
    }
    self.backScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ;
    [self setNeedsLayout] ;
}

- (void)initSubviews{
    // clear Subview
    NSAssert(self.dataSource, @"DataSource can't be nil") ;
    for(UIView *view in self.backScrollView.subviews){
        [view removeFromSuperview] ;
    }
    
    NSAssert([self.dataSource respondsToSelector:@selector(numberOfItemInTopDisplayControl:)], @"DataSource must can response numberOfItemsInSection method") ;
    if ([self.dataSource respondsToSelector:@selector(numberOfItemInTopDisplayControl:)]) {
        self.itemsCount = [self.dataSource numberOfItemInTopDisplayControl:self] ;
    }
    
    CGFloat scrollTotalWidth = 0 ;
    for(int i = 0 ; i < self.itemsCount ; i++){
        CGFloat itemWidth = DEFAULT_ITEM_WIDTH ;
        if([self.dataSource respondsToSelector:@selector(widthForItemInTopDisplayControl:index:)]){
            itemWidth = [self.dataSource widthForItemInTopDisplayControl:self index:i] ;
        }
        CGRect itemFrame = CGRectMake(scrollTotalWidth, 0, itemWidth, self.backScrollView.frame.size.height) ;
        scrollTotalWidth += itemWidth ;
        
        NSString *title = @"" ;
        if([self.dataSource respondsToSelector:@selector(topDisplayControl:titleForItemAtIndex:)]){
            title = [self.dataSource topDisplayControl:self titleForItemAtIndex:i] ;
        }
        
        SITopDisplayItem *item = nil ;
        if(i == 0){
            item = [[SITopDisplayItem alloc]initWithFrame:itemFrame withTitle:title defaultBackgroundImage:self.itemBackgroundImageLeft] ;
            // 创建分隔线
            UIView *spearView = [[UIView alloc]initWithFrame:CGRectMake(itemFrame.size.width - 1, 0, 1, itemFrame.size.height)] ;
            spearView.backgroundColor = self.dividLineColor ;
            spearView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin ;
            [item addSubview:spearView] ;
        }else if(i == self.itemsCount - 1){
            item = [[SITopDisplayItem alloc]initWithFrame:itemFrame withTitle:title defaultBackgroundImage:self.itemBackgroundImageRight] ;
        }else{
            item = [[SITopDisplayItem alloc]initWithFrame:itemFrame withTitle:title defaultBackgroundImage:self.itemBackgroundImageMiddle] ;
            UIView *spearView = [[UIView alloc]initWithFrame:CGRectMake(itemFrame.size.width-1, 0, 1, itemFrame.size.height)] ;
            spearView.backgroundColor = self.dividLineColor ;
            spearView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin ;
            [item addSubview:spearView] ;
        }
        
        item.index = i ;
        item.amplifySelectedTitle = self.amplifySelectedTitle ;
        item.selectedBackgroundImage = self.selectedBackgroundImage ;
        item.unSelectedBackgroundImage = self.unSelectedBackgroundImage ;
        item.delegate = self ;
        item.titleFont = self.titleFont ;
        item.normalColor = self.normalColor ;
        item.selectedColor = self.selectedColor ;
        item.backgroundColor = [UIColor clearColor] ;
        [self.backScrollView addSubview:item] ;
        if(i == willSelctedIndex){
            [item switchToSelected] ;
        }else{
            [item switchToNormal] ;
        }
    }
    
    // 设置content
    self.backScrollView.contentSize = CGSizeMake(scrollTotalWidth, self.frame.size.height) ;
    
    // 设置默认选择第一个
    if(self.moveImageView){
        [self.backScrollView scrollRectToVisible:self.backScrollView.frame animated:NO] ;
        [self.backScrollView addSubview:self.moveImageView] ;
        [self selectedItemForIndex:willSelctedIndex animated:NO] ;
    }else{
        UIView *firstView ;
        if (self.backScrollView.subviews.count > 0) {
            firstView = [self.backScrollView.subviews firstObject] ;
        }
        self.moveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-2, firstView.frame.size.width, 2)] ;
        
        if (!self.moveViewColor) {
            self.moveViewColor = [UIColor colorWithRed:0.48 green:0.48 blue:0.48 alpha:0.5] ;
        }
        self.moveImageView.backgroundColor = self.moveViewColor ;
        [self.backScrollView addSubview:self.moveImageView]; ;
        [self selectedItemForIndex:willSelctedIndex animated:NO] ;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews] ;
    [self initSubviews] ;
}

- (SITopDisplayItem *)itemForIndex:(NSInteger)index{
    for(UIView *view in self.backScrollView.subviews){
        if ([view isKindOfClass:[SITopDisplayItem class]]) {
            SITopDisplayItem *item = (SITopDisplayItem *)view ;
            if (index == item.index) {
                return item ;
            }
        }
    }
    return nil ;
}

- (void)selectedItemForIndex:(NSInteger)index animated:(BOOL)animaled{
    if (index != selectedIndex) {
        if (index < self.itemsCount) {
            UIView *subView = self.backScrollView.subviews[index] ;
            [self.backScrollView scrollRectToVisible:subView.frame animated:animaled] ;
            if (selectedIndex > index) {
                if (index > 0) {
                    UIView *subviewPre = self.backScrollView.subviews[index - 1] ;
                    [self.backScrollView scrollRectToVisible:subviewPre.frame animated:animaled] ;
                }
            }else{
                if(index < self.itemsCount - 1){
                    UIView *subViewNext = self.backScrollView.subviews[index+1] ;
                    [self.backScrollView scrollRectToVisible:subViewNext.frame animated:animaled] ;
                }
            }
            
            if(animaled){
                // 开启移动图片的动画
                [UIView beginAnimations:nil context:nil] ;
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut] ;
                [UIView setAnimationRepeatAutoreverses:NO] ;
                [UIView setAnimationDidStopSelector:@selector(hiddenGripAfterAnimation)];
                [UIView setAnimationDuration:0.3];
                [UIView setAnimationDelegate:self];
            }
            
            // 设置下面图片的偏移量
            self.moveImageView.frame = CGRectMake(subView.frame.origin.x, self.moveImageView.frame.origin.y, subView.frame.size.width, self.moveImageView.frame.size.height) ;
            if(animaled){
                [UIView commitAnimations] ;
            }
            
            // 更新上一次选中位置变量
            self.lastSelectedIndex = selectedIndex ;
            selectedIndex = index ;
            if(self.lastSelectedIndex != selectedIndex){
                // 不相同
                SITopDisplayItem *item = [self itemForIndex:self.lastSelectedIndex] ;
                [item switchToNormal] ;
            }
            
            if (!animaled) {
                [self hiddenGripAfterAnimation] ;
            }
        }else{
            willSelctedIndex = index ;
        }
    }
}

- (void)hiddenGripAfterAnimation{
    // 动画结束将当前选中的item切换到选中状态
    SITopDisplayItem *selectedItem = [self itemForIndex:selectedIndex] ;
    [selectedItem switchToSelected] ;
}

- (void)didSelectedOnItem:(SITopDisplayItem *)item{
    if([self.dataSource respondsToSelector:@selector(topDisplayControl:willSelectedAtIndex:)]){
        [self.dataSource topDisplayControl:self willSelectedAtIndex:item.index] ;
    }
    
    if(selectedIndex == item.index){
        return ;
    }
    
    self.lastSelectedIndex = selectedIndex ;
    
    [self selectedItemForIndex:item.index animated:YES];
    
    if ([self.dataSource respondsToSelector:@selector(topDisplayControl:didSelectedAtIndex:)]) {
        [self.dataSource topDisplayControl:self didSelectedAtIndex:item.index] ;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectedItemForIndex:animated:)]) {
        [self.delegate selectedItemForIndex:item.index animated:YES] ;
    }
    
    selectedIndex = item.index ;
}

@end
