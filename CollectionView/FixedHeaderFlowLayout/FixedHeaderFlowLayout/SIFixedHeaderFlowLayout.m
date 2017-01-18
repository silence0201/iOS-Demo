//
//  SIFixedHeaderFlowLayout.m
//  SIFixedHeaderFlowLayout
//
//  Created by 杨晴贺 on 18/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "SIFixedHeaderFlowLayout.h"

static CGFloat const navHeight = 64 ;

@implementation SIFixedHeaderFlowLayout

// 当滑动时,重新进行布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES ;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    // 获取原来的布局信息
    NSMutableArray *attributesArr = [[super layoutAttributesForElementsInRect:rect] mutableCopy] ;
    
    NSMutableIndexSet *noHeaderSections = [NSMutableIndexSet indexSet] ;
    // 当前所有的基本信息
    for (UICollectionViewLayoutAttributes *attributes in attributesArr){
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            [noHeaderSections addIndex:attributes.indexPath.section] ;
        }
    }
    
    for(UICollectionViewLayoutAttributes *attributes in attributesArr){
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [noHeaderSections removeIndex:attributes.indexPath.section] ;
        }
    }
    
    // 处理因回收后的
    [noHeaderSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx] ;
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath] ;
        if(attributes){
            [attributesArr addObject:attributes] ;
        }
    }] ;
    
    for (UICollectionViewLayoutAttributes *attributes in attributesArr){
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
            NSInteger numberItemInSection = [self.collectionView numberOfItemsInSection:attributes.indexPath.section] ;
            NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:attributes.indexPath.section] ;
            NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberItemInSection-1) inSection:attributes.indexPath.section] ;
            
            UICollectionViewLayoutAttributes *firstItemAttributes, *lastItemAttributes ;
            if (numberItemInSection>0){
                firstItemAttributes = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
                lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
            }else{
                firstItemAttributes = [UICollectionViewLayoutAttributes new];
                CGFloat y = CGRectGetMaxY(attributes.frame)+self.sectionInset.top;
                firstItemAttributes.frame = CGRectMake(0, y, 0, 0);
                lastItemAttributes = firstItemAttributes;
            }
            
            CGRect rect = attributes.frame ;
            CGFloat offset = self.collectionView.contentOffset.y + navHeight ;
            CGFloat headerY = firstItemAttributes.frame.origin.y - rect.size.height - self.sectionInset.top;
            
            CGFloat maxY = MAX(offset,headerY);
            
            CGFloat headerMissingY = CGRectGetMaxY(lastItemAttributes.frame) + self.sectionInset.bottom - rect.size.height;
            rect.origin.y = MIN(maxY,headerMissingY);
            attributes.frame = rect;
            attributes.zIndex = 1000 ;
        }
    }
    
    return attributesArr ;
    
}

@end
