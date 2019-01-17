//
//  FixCollectionLayout.h
//  CollectionFixDemo
//
//  Created by Silence on 2019/1/17.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FixCollectionLayoutDelegate <NSObject>
/// 获取cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
/// 次级表头的总层数
- (NSInteger)levelOfHeadersInCollectionView:(UICollectionView *)collectionView;
/// 每层表头单个元素所占的格数
- (NSArray *)collectionView:(UICollectionView *)collectionView eachCellWidthOfLevel:(NSInteger)level;
@end

@interface FixCollectionLayout : UICollectionViewLayout

@property(nonatomic, weak) id<FixCollectionLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
