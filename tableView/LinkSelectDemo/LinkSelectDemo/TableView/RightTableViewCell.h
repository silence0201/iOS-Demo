//
//  RightTableViewCell.h
//  LinkSelectDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCellIdentifier_Right @"RightTableViewCell"

@class FoodModel ;

@interface RightTableViewCell : UITableViewCell

// 模型对象
@property (nonatomic,strong) FoodModel *model ;

@end
