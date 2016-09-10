//
//  MyCollectionViewFlowLayout.m
//  CollectionViewLinkDemo
//
//  Created by 杨晴贺 on 9/10/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MyCollectionViewFlowLayout.h"

@implementation MyCollectionViewFlowLayout

- (instancetype)init{
    if (self = [super init]) {
        self.navHeight = 0.0f ;
    }
    return self ;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    // UICollectionViewLayoutAttributes:CollectionView中item(包括cell,header,footer)的结构信息
    // 截取父类的返回数组,并转化为可变数组
    NSMutableArray *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy] ;
    
    // 创建存索引的数组,无符号,无需,不可重复
    NSMutableIndexSet *noneHeaderSections = [NSMutableIndexSet indexSet] ;
    
    // 遍历superArray,得到一个当前屏幕中所有的section数组
    for(UICollectionViewLayoutAttributes *attributes in superArray){
        //  如果当前的元素分类是一个cell,将cell所在的分区section加入数组,重复的话会自动过滤
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            [noneHeaderSections addIndex:attributes.indexPath.section] ;
        }
    }
    
    // 遍历superArray,将当前屏幕中拥有header的section从数组中移除,得到一个当前屏幕中没有header的section数组
    // 正常情况下,随着手机上移,header脱离屏幕会被系统回收而cell尚在,也会触发这个方法
    for(UICollectionViewLayoutAttributes *attributes in superArray){
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [noneHeaderSections removeIndex:attributes.indexPath.section] ;
        }
    }
    
    // 遍历当前屏幕中没有header的section数组
    [noneHeaderSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        // 取到当前section中第一个item的indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx] ;
        // 获取当前section在正常情况下已经离开屏幕的header的结构信息
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath] ;
        // 如果当前分区确实有因为离开屏幕而被回收的header
        if(attributes){
            // 将改Header结构信息重新写入到superArray中
            [superArray addObject:attributes] ;
        }
    }] ;
    
    // 遍历superArray,改变Header结构信息中的参数,使他可以在当前section还没有离开屏幕的时候一直显示
    for(UICollectionViewLayoutAttributes *attributes in superArray){
        // 如果当前item是Header
        if([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
            // 得到当前Header所在分区cell的数量
            NSInteger numberOfItemInSection = [self.collectionView numberOfItemsInSection:attributes.indexPath.section] ;
            // 得到第一个item的indexPath
            NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:attributes.indexPath.section] ;
            //得到最后一个item的indexPath
            NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItemInSection - 1) inSection:attributes.indexPath.section] ;
            
            // 得到第一个和最后一个的item的结构信息
            UICollectionViewLayoutAttributes *firstItemAttributes,*lastItemAttributes ;
            if (numberOfItemInSection > 0) {
                // cell有值,则获取第一个cell和最后一个cell的结构信息
                firstItemAttributes = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath] ;
                lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath] ;
            }else{
                // cell没值,就新建一个UICollectionViewLayoutAttributes
                firstItemAttributes = [UICollectionViewLayoutAttributes new] ;
                // 然后模拟出当前分区中唯一一个cell,cell在Header下面,高度为0,还与header隔着可能存在sectionInset的top
                CGFloat y = CGRectGetMaxX(attributes.frame) + self.sectionInset.top ;
                firstItemAttributes.frame = CGRectMake(0, y, 0, 0) ;
                // 因为只有一个cell,所以最后一个cell等于第一个cell
                lastItemAttributes = firstItemAttributes ;
            }
            
            // 获取当前Header的frame
            CGRect rect = attributes.frame ;
            // 当前的滑动距离 + 因为导航栏产生的偏移量，默认为64（如果app需求不同，需自己设置）
            CGFloat offset = self.collectionView.contentOffset.y + _navHeight;
            // 第一个cell的y值 - 当前header的高度 - 可能存在的sectionInset的top
            CGFloat headerY = firstItemAttributes.frame.origin.y - rect.size.height - self.sectionInset.top;
            // 哪个大取哪个，保证header悬停
            // 针对当前header基本上都是offset更加大，针对下一个header则会是headerY大，各自处理
            CGFloat maxY = MAX(offset, headerY);
            // 最后一个cell的y值 + 最后一个cell的高度 + 可能存在的sectionInset的bottom - 当前header的高度
            // 当当前section的footer或者下一个section的header接触到当前header的底部，计算出的headerMissingY即为有效值
            CGFloat headerMissingY = CGRectGetMaxY(lastItemAttributes.frame) + self.sectionInset.bottom - rect.size.height;
            // 给rect的y赋新值，因为在最后消失的临界点要跟谁消失，所以取小
            rect.origin.y = MIN(maxY, headerMissingY);
            // 给header的结构信息的frame重新赋值
            attributes.frame = rect;
            // 如果按照正常情况下,header离开屏幕被系统回收，而header的层次关系又与cell相等，如果不去理会，会出现cell在header上面的情况
            // 通过打印可以知道cell的层次关系zIndex数值为0，我们可以将header的zIndex设置成1，如果不放心，也可以将它设置成非常大，这里随便填了个7
            attributes.zIndex = 7;
            
        }
    }
    
    // 转换回不可变数组，并返回
    return [superArray copy];
}

// 表示一旦滑动就是实时调用layoutAttributesForElementsInRect:方法
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES ;
}


@end
