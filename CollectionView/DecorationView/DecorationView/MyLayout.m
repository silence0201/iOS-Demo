//
//  MyLayout.m
//  DecorationView
//
//  Created by 杨晴贺 on 10/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "MyLayout.h"
#import "MyDecorationView.h"

// 1. prepareLayout 准备布局，在此方法内设置初始参数 ，注册装饰视图等。
// 2. collectionViewContentSize 集合视图大小：确定collectionView 占据的尺寸，注意：这里是所有内容尺寸，不是可见内容尺寸。
// 3. layoutAttributesForElementsInRect  返回矩形范围中，每个元素的布局属性，返回值为一个数组
// 4. 再次执行 collectionViewContentSize 来确定集合内容视图大小，确定滚动范围。
// 另外，在需要更新layout时，需要给当前layout发送 -invalidateLayout，该消息会立即返回，并且预约在下一个loop的时候刷新当前layout，这一点和UIView的setNeedsLayout方法十分类似。在-invalidateLayout后的下一个collectionView的刷新loop中，又会从prepareLayout开始，依次再调用-collectionViewContentSize和-layoutAttributesForElementsInRect来生成更新后的布局。

static NSString *const kDecorationViewOfKind = @"DecorationViewOfKind" ;
@implementation MyLayout

- (void)prepareLayout{
    [super prepareLayout] ;
    // 注册装饰视图,重用标识符dv1
    [self registerClass:[MyDecorationView class] forDecorationViewOfKind:kDecorationViewOfKind] ;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath] ;
    // 赋值
    CGFloat width = self.collectionView.frame.size.width ;
    CGFloat height =[UIScreen mainScreen].bounds.size.width / 3 ;
    
    CGFloat attX = 0 ;
    CGFloat attY = indexPath.section * height ;
    
    attributes.frame = CGRectMake(attX, attY, width, height) ;
    attributes.zIndex = -1 ;
    
    return attributes ;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributeArray = [NSMutableArray array] ;
    for(int section = 0 ; section < self.collectionView.numberOfSections;section++){
        // 装饰视图属性
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section]  ;
        UICollectionViewLayoutAttributes *arr =  [self layoutAttributesForDecorationViewOfKind:kDecorationViewOfKind atIndexPath:indexPath] ;
        [attributeArray addObject:arr] ;
        
        
        // Item
        for(int item = 0 ; item < [self.collectionView numberOfItemsInSection:section];item++){
            NSIndexPath *idx = [NSIndexPath indexPathForItem:item inSection:section] ;
            UICollectionViewLayoutAttributes *atts = [self layoutAttributesForItemAtIndexPath:idx] ;
            [attributeArray addObject:atts] ;
        }
    }
    return attributeArray ;
}

@end
