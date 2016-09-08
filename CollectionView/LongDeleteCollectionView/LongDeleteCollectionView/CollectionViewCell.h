//
//  CollectionViewCell.h
//  LongDeleteCollectionView
//
//  Created by 杨晴贺 on 9/8/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@protocol CollectionViewDelegate <NSObject>

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath ;
- (void)showAllDeleteBtn ;
- (void)hideAllDeleteBtn ;

@end


@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) id<CollectionViewDelegate> delegate ;

@property (nonatomic,strong) UIImageView *imageView ;
@property (nonatomic,strong) UIButton *btn ;
@property (nonatomic,strong) NSIndexPath *path;


@end
