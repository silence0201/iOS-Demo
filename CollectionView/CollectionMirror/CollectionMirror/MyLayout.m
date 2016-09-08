//
//  MyLayout.m
//  CollectionMirror
//
//  Created by 杨晴贺 on 9/8/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout{
    CGSize _boundSize ;
    CGFloat _midX ;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES ;
}

- (void)prepareLayout{
    [super prepareLayout] ;
    _boundSize = self.collectionView.bounds.size ;
    _midX = _boundSize.width / 2.0f ;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect] ;
    for(UICollectionViewLayoutAttributes *attribute in array){
        CGPoint contentOffSet = self.collectionView.contentOffset ;
        /*
         attributes.center.x : 当前单元格在collectionview上的中心坐标 205 = 80 + 单元格宽度250/2;
         contentOffset.x : collectionView的x轴偏移量
         */
        CGFloat centerX = attribute.center.x - contentOffSet.x ; //当前item中心值减去collectionView.x 的偏移值
        CGFloat space = _midX - centerX ; // 单元格与中心的距离
        CGFloat distance = ABS(space) ;  //得到space的位置
        CGFloat normalized = distance / _midX ; //当当前单元格在正中间时，为0，
        
        NSLog(@"当前item中心%f----偏移值%f-----距离%f-----比例%f",attribute.center.x,contentOffSet.x,distance,normalized);
        CGFloat zoom = 1 + 0.2 * (1-ABS(normalized));//放大的倍数
        attribute.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0f);
    }
    return array ;
}

@end
