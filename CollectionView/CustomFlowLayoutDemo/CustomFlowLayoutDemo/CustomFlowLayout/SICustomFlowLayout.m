//
//  SICustomFlowLayout.m
//  CustomFlowLayoutDemo
//
//  Created by 杨晴贺 on 11/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "SICustomFlowLayout.h"

/// cell放大和缩小,停止滚动是:Cell居中
@implementation SICustomFlowLayout

// 布局准备
- (void)prepareLayout{
    [super prepareLayout] ;
    
    // 水平排列
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    // 设置内边距
    CGFloat insert =(self.collectionView.frame.size.width-self.itemSize.width)/2;
    self.sectionInset =UIEdgeInsetsMake(20, insert, 20, insert);
}
// 设置当显示的范围发生改变时,是否重新发生布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES ;
}

// 所有元素的排列
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect] ;
    
    // 计算CollectionView最中心的X值
    CGFloat centX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2 ;
    for(UICollectionViewLayoutAttributes *atts in array){
        // cell的中心点x 和CollectionView最中心点的x值
        CGFloat delta = ABS(atts.center.x - centX);
        // 根据间距值  计算cell的缩放的比例
        // 这里scale 必须要 小于1
        CGFloat scale = 1 - delta/self.collectionView.frame.size.width;
        // 设置缩放比例
        atts.transform=CGAffineTransformMakeScale(scale, scale);
    }
    return  array ;
}

// 只要手一松开就会开始调用
// 这个方法的返回值，就决定了CollectionView停止滚动时的偏移量
// proposedContentOffset这个是最终的 偏移量的值 但是实际的情况还是要根据返回值来定
// velocity  是滚动速率  有个x和y 如果x有值 说明x上有速度
// 如果y有值 说明y上又速度 还可以通过x或者y的正负来判断是左还是右（上还是下滑动）  有时候会有用
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    // 计算出 最终显示矩形框
    CGRect rect ;
    rect.origin.x = proposedContentOffset.x ;
    rect.origin.y = 0 ;
    rect.size = self.collectionView.frame.size ;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect] ;
    // 计算CollectionView最中心点的x值 这里要求 最终的 要考虑惯性
    CGFloat centerX = self.collectionView.frame.size.width /2+ proposedContentOffset.x;
    
    // 存放的最小间距
    CGFloat minDelta = MAXFLOAT ;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        if (ABS(minDelta)>ABS(attrs.center.x-centerX)) {
            minDelta=attrs.center.x-centerX;
        }
    }
    
    // 修改原有的偏移量
    proposedContentOffset.x+=minDelta;
    //如果返回的时zero 那个滑动停止后 就会立刻回到原地
    return proposedContentOffset;
}

@end
