//
//  SICollectViewAlignLayout.m
//  CollectViewAlignDemo
//
//  Created by 杨晴贺 on 09/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "SICollectViewAlignLayout.h"

@implementation SICollectViewAlignLayout{
    SICollectViewAlign _alignType ;
}

- (instancetype)initWithAlignType:(SICollectViewAlign)type{
    if (self = [super init]) {
        _alignType = type ;
    }
    return self ;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSInteger left = -1 ;
    NSInteger right = -1 ;
    CGFloat width = 0 ;
    NSInteger section = 0 ;
    CGFloat lastX = self.collectionView.frame.size.width ;
    NSMutableArray *updateAttributres = [[NSMutableArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES] ;
    
    for (NSInteger i = 0; i < [updateAttributres count]; i ++) {
        UICollectionViewLayoutAttributes *attributes = updateAttributres[i];
        if (!attributes.representedElementKind) {
            section = attributes.indexPath.section;
            if(attributes.frame.origin.x < lastX) {
                if(left != -1) {
                    //处理上一行的内容
                    [self getAttributesForLeft:left right:right offset:[self calOffset:section width:width] originalAttributes:updateAttributres];
                }
                left = i;
                lastX = attributes.frame.origin.x + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:section];
                width = [self evaluatedSectionInsetForItemAtIndex:section].left + [self evaluatedSectionInsetForItemAtIndex:section].right - [self evaluatedMinimumInteritemSpacingForSectionAtIndex:section];
            }
            lastX = attributes.frame.origin.x + attributes.frame.size.width + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:section];
            right = i;
            width += attributes.frame.size.width + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:section];
            
        }
    }

    if (left != -1) {
        [self getAttributesForLeft:left right:right offset:[self calOffset:section width:width] originalAttributes:updateAttributres];
    }
    
    return updateAttributres ;
}


- (CGFloat)calOffset:(NSInteger)section width:(CGFloat)width {
    CGFloat offset = [self evaluatedSectionInsetForItemAtIndex:section].left;
    switch (_alignType) {
        case SICollectViewAlignLeft:
            break;
        case SICollectViewAlignRight:
            offset += self.collectionView.frame.size.width - width;
            break;
        case SICollectViewAlignCenter:
            offset += (self.collectionView.frame.size.width - width) / 2;
            break;
        default:
            break;
    }
    return offset;
}

- (void)getAttributesForLeft:(NSInteger)left right:(NSInteger) right offset:(CGFloat)offset originalAttributes:(NSMutableArray *)updatedAttributes {
    CGFloat currentOffset = offset;
    for(NSInteger i = left; i <= right; i ++) {
        UICollectionViewLayoutAttributes *attributes = updatedAttributes[i];
        CGRect frame = attributes.frame;
        frame.origin.x = currentOffset;
        attributes.frame = frame;
        currentOffset += frame.size.width + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:attributes.indexPath.section];
        [updatedAttributes setObject:attributes atIndexedSubscript:i];
    }
}

- (CGFloat)evaluatedMinimumInteritemSpacingForSectionAtIndex:(NSInteger)sectionIndex {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [(id)self.collectionView.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:sectionIndex];
    } else {
        return self.minimumInteritemSpacing;
    }
}

- (UIEdgeInsets)evaluatedSectionInsetForItemAtIndex:(NSInteger)index {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [(id)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
    } else {
        return self.sectionInset;
    }
}





@end
