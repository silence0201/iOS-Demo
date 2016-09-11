//
//  MusicCell.h
//  Music Player
//
//  Created by 杨晴贺 on 8/4/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Music.h"

@interface MusicCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *显示模型数据
 */
-(void)setMusic:(Music *)msc;

@end
