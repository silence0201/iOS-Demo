//
//  SIImageCell.h
//  CollectionPictureCycleDemo
//
//  Created by 杨晴贺 on 9/7/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#define imageCount 9

@interface SIImageCell : UICollectionViewCell

@property (nonatomic,copy) NSString *imagePath ;

@property (nonatomic,strong) NSIndexPath *currentPath ;

@end
