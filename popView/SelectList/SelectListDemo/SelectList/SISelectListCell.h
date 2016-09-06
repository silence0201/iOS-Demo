//
//  SelectListCell.h
//  SelectListDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SISelectListItem ;
@interface SISelectListCell : UITableViewCell

/**
 *  数据对象
 */
@property (nonatomic,strong) SISelectListItem *item ;

@end
