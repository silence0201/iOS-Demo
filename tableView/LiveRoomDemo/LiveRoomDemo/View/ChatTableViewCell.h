//
//  ChatTableViewCell.h
//  LiveRoomDemo
//
//  Created by Silence on 2018/2/26.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell

+ (instancetype)crateChatTableViewCellWithTable:(UITableView *)tableView ;

- (void)setCellAttributTitle:(NSAttributedString *)str;

@end
