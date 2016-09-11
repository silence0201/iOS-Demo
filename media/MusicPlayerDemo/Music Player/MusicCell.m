//
//  MusicCell.m
//  Music Player
//
//  Created by 杨晴贺 on 8/4/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MusicCell.h"

@implementation MusicCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"Music";
    return [tableView dequeueReusableCellWithIdentifier:ID];
}

-(void)setMusic:(Music *)msc{
    //显示模型数据
    self.textLabel.text = msc.name;
    self.detailTextLabel.text = msc.singer;
}

@end
