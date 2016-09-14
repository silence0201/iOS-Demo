//
//  SIWaterFlowLayoutDelegate.m
//  WaterFlowLayoutDemo
//
//  Created by 杨晴贺 on 9/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SIWaterFlowLayout.h"

// 默认值
static const CGFloat inset = 10 ;
static const NSInteger colCount = 3 ;

@interface SIWaterFlowLayout ()

@property (nonatomic,strong) NSMutableDictionary *colMaxYDic ; // 保存对应列的y值

@end

@implementation SIWaterFlowLayout

/**
 *  初始化layout自定调用,需要在该方法中初始化一些自定义的变量参数
 */
- (void)prepareLayout{
    [super prepareLayout] ;
    
    self.colMaxYDic = [NSMutableDictionary dictionary] ;
}


#pragma mark - Core Method
/**
 *   当collection view的bounds改变时，布局需要告诉collection view是否需要重新计算布局
 *
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES ;
}

/**
 *  设置UICollectionView的内容的大小,类似ScrollView的contentSize
 */
- (CGSize)collectionViewContentSize{
    __block NSString *maxCol = @"0" ;
    // 遍历出最高的列
    [self.colMaxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj floatValue] > [self.colMaxYDic[maxCol] floatValue]) {
            maxCol = key ;
        }
    }] ;
    return CGSizeMake(0, [self.colMaxYDic[maxCol] floatValue]) ;
}

/**
 *  初始化布局外观
 *
 *  @param rect 所有元素的布局属性
 *
 *  @return 所有元素的布局
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    for(NSInteger i = 0 ; i < self.colCount ; i++){
        NSString *col = [NSString stringWithFormat:@"%ld",i] ;
        self.colMaxYDic[col] = @(0) ;
    }
    
    NSMutableArray *attributeArray = [NSMutableArray array] ;
    
    for(NSInteger i = 0 ;i<[self.collectionView numberOfSections];i++){
        // header
        UICollectionViewLayoutAttributes *headerAtts = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]] ;
        [attributeArray addObject:headerAtts] ;
        
        // items
        NSInteger count = [self.collectionView numberOfItemsInSection:i] ;
        for(NSInteger j = 0 ;j < count; j++){
            UICollectionViewLayoutAttributes *atts = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]] ;
            [attributeArray addObject:atts] ;
        }
        
        // footer
        UICollectionViewLayoutAttributes *footerAtts = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]] ;
        [attributeArray addObject:footerAtts] ;
    }
    return attributeArray ;
}

#pragma mark - Private Method
/**
 *  根据不同的indexPath生成对应的布局
 *
 *  @param indexPath indexPath
 *
 *  @return 布局信息对象
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    __block NSString *minCol = @"0" ;
    // 遍历找出最短的列
    [self.colMaxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if([obj floatValue] < [self.colMaxYDic[minCol] floatValue]){
            minCol = key ;
        }
    }] ;
    
    // width
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.colCount - 1) * self.itemSpace)/self.colCount ;
    
    // height
    CGFloat height = 0 ;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForWidth:atIndexPath:)]) {
        height = [self.delegate collectionView:self.collectionView layout:self heightForWidth:width atIndexPath:indexPath] ;
    }
    
    CGFloat x = self.sectionInset.left + (width + self.itemSpace) * [minCol intValue] ;
    
    CGFloat space = 0 ;
    if (indexPath.item < self.colCount) {
        space = 0 ;
    }else{
        space = self.lineSpace ;
    }
    
    CGFloat y = [self.colMaxYDic[minCol] floatValue] + space;
    
    // 更新对应列的高度
    self.colMaxYDic[minCol] = @(y + height) ;
    
    // 计算位置
    UICollectionViewLayoutAttributes *attrItem = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath] ;
    attrItem.frame = CGRectMake(x, y, width, height) ;
    
    return attrItem ;
}

/**
 *  Header和footer布局属性
 *
 *  @param elementKind 类型
 *  @param indexPath   indexPath
 *
 *  @return 布局信息对象
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    __block NSString *maxCol = @"0" ;
    
    // 遍历找出最高的列
    [self.colMaxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if([obj floatValue] > [self.colMaxYDic[maxCol] floatValue]){
            maxCol = key ;
        }
    }] ;
    
    // header
    if([UICollectionElementKindSectionHeader isEqualToString:elementKind]){
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath] ;
        
        // size
        CGSize size = CGSizeZero ;
        if([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]){
            size = [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section] ;
        }
        CGFloat x = self.sectionInset.left ;
        CGFloat y = [self.colMaxYDic[maxCol] floatValue] + self.sectionInset.top ;
        
        // 更新所有对应的列的高度
        for(NSString *key in self.colMaxYDic.allKeys){
            self.colMaxYDic[key] = @(y + size.height) ;
        }
        attrs.frame = CGRectMake(x, y, size.width, size.height) ;
        return attrs ;
    }else{
        // footer
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath] ;
        
        // size
        CGSize size = CGSizeZero ;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
            size = [self.delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section] ;
        }
        
        CGFloat x = self.sectionInset.left ;
        CGFloat y = [self.colMaxYDic[maxCol] floatValue] ;
        
        // 更新所有对应的高度
        for(NSString *key in self.colMaxYDic.allKeys){
            self.colMaxYDic[key] = @(y + size.height + self.sectionInset.bottom) ;
        }
        attrs.frame = CGRectMake(x, y, size.width, size.height) ;
        return attrs ;
    }
}

@end
