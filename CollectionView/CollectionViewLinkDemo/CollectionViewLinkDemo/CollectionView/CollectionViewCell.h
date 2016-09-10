//
//  CollectionViewCell.h
//  CollectionViewLinkDemo
//
//  Created by 杨晴贺 on 9/10/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCellIdentifier_CollectionView @"CollectionViewCell"

@class SubCategoryModel ;

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) SubCategoryModel *model ;

@end
