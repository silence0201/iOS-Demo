//
//  CityViewCell.h
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityViewCellDelegate <NSObject>

- (void)selectCityNameInCollectionCell:(NSString *)cityName ;

@end

@interface CityViewCell : UITableViewCell

@property (nonatomic,strong) NSArray *cityArray ;
@property (nonatomic,weak) id<CityViewCellDelegate> delegate ;

@end
