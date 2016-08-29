//
//  FriendCell.m
//  ListTableView
//
//  Created by 杨晴贺 on 8/29/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "FriendCell.h"
#import "Friend.h"

@implementation FriendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"friendCell" ;
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell == nil) {
        cell = [[FriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
    }
    return cell ;
}

- (void)setFriendData:(Friend *)friendData{
    _friendData = friendData ;
    
    self.imageView.image = [UIImage imageNamed:friendData.icon] ;
    self.textLabel.text = friendData.name ;
    self.textLabel.textColor = friendData.isVip ? [UIColor redColor] : [UIColor blackColor];
    self.detailTextLabel.text = friendData.intro ;
}

@end
