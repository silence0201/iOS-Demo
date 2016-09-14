//
//  SIWaterFlowLayoutDelegate.h
//  WaterFlowLayoutDemo
//
//  Created by 杨晴贺 on 9/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SIWaterFlowLayout ;
@protocol SIWaterFlowLayoutDelegate <NSObject>

@required
/**
 *  返回item的高度
 *
 *  @param collectionView  collectionView
 *  @param waterFlowLayout waterFlowLayout
 *  @param width           item的高度
 *  @param indexPath       indexPath
 *
 *  @return item的高度
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SIWaterFlowLayout *)waterFlowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath ;

@optional
/**
 *  返回Header的Size
 *
 *  @param collectionView  collectionView
 *  @param waterFlowLayout waterFlowLayout
 *  @param section         选择的section
 *
 *  @return Header的Size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SIWaterFlowLayout *)waterFlowLayout referenceSizeForHeaderInSection:(NSInteger)section ;

/**
 *  返回footer的Size
 *
 *  @param collectionView  collectionView
 *  @param waterFlowLayout waterFlowLayout
 *  @param section         选择的section
 *
 *  @return footer的Size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SIWaterFlowLayout *)waterFlowLayout referenceSizeForFooterInSection:(NSInteger)section ;

@end

@interface SIWaterFlowLayout : UICollectionViewLayout

/**
 *  section的边距
 */
@property(nonatomic,assign) UIEdgeInsets sectionInset ;
/**
 *  水平间距
 */
@property (nonatomic,assign) CGFloat itemSpace ;
/**
 *  垂直间距
 */
@property (nonatomic,assign) CGFloat lineSpace ;
/**
 *  列数
 */
@property (nonatomic,assign) NSInteger colCount ;
/**
 *  代理
 */
@property (nonatomic,weak) id<SIWaterFlowLayoutDelegate> delegate ;

@end
