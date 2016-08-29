//
//  HeaderView.h
//  ListTableView
//
//  Created by 杨晴贺 on 8/29/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendGroup, HeaderView ;

@protocol HeadViewDelegate <NSObject>

@optional
- (void) headerViewDidClickedNameView:(HeaderView *)headView ;

@end

@interface HeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView ;

/**
 *  数据模型
 */
@property (nonatomic,strong) FriendGroup *group ;

/**
 *  代理
 */
@property (nonatomic,weak) id<HeadViewDelegate> delegate ;

@end
