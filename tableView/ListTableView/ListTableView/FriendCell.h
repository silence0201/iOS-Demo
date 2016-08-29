//
//  FriendCell.h
//  ListTableView
//
//  Created by 杨晴贺 on 8/29/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Friend ;
@interface FriendCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView ;

/**
 *  模型对象
 */
@property (nonatomic,strong) Friend *friendData ;

@end
