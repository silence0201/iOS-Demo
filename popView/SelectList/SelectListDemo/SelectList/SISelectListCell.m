//
//  SelectListCell.m
//  SelectListDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SISelectListCell.h"
#import "SISelectListItem.h"

@implementation SISelectListCell

- (void)setItem:(SISelectListItem *)item{
    _item = item ;
    self.imageView.image = item.iconImage ;
    self.textLabel.text = item.title ;
    self.textLabel.textColor = [UIColor whiteColor] ;
    self.textLabel.font = [UIFont systemFontOfSize:15] ;
}

- (void)layoutSubviews{
    [super layoutSubviews] ;
    
    self.layer.cornerRadius = 3 ;
    self.layer.masksToBounds = YES ;
    
    self.imageView.frame = CGRectMake(15, 10, 20, 20) ;
    
    CGRect tmpFrame = self.textLabel.frame ;
    tmpFrame.origin.x = 45 ;
    tmpFrame.size.width = 80 ;
    
    self.textLabel.frame = tmpFrame ;
}

@end
