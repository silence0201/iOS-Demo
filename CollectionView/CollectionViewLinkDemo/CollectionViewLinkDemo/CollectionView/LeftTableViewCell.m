//
//  LeftTableViewCell.m
//  LinkSelectDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "LeftTableViewCell.h"

@interface LeftTableViewCell ()

@property (nonatomic,strong) UIView *yellowView ;

@end

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 40)] ;
        self.nameLabel.numberOfLines = 0 ;
        self.nameLabel.font = [UIFont systemFontOfSize:15] ;
        self.nameLabel.textColor = rgba(130, 130, 130, 1) ;
        self.nameLabel.highlightedTextColor = defaultColor ;
        [self.contentView addSubview:self.nameLabel] ;
        
        self.yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 6, 5, 45)] ;
        self.yellowView.backgroundColor = defaultColor ;
        [self.contentView addSubview:self.yellowView] ;
    }
    return self ;
}

// 选中效果
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated] ;
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1] ;
    self.highlighted = selected ;
    self.nameLabel.highlighted = selected ;
    self.yellowView.hidden = !selected ;
}

@end
