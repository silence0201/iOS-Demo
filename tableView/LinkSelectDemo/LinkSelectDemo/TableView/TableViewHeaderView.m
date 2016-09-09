//
//  TableViewHeaderView.m
//  LinkSelectDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TableViewHeaderView.h"

@implementation TableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = rgba(240, 240, 240, 0.8) ;
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 20)] ;
        self.nameLabel.font = [UIFont systemFontOfSize:13] ;
        [self addSubview:self.nameLabel] ;
    }
    return self ;
}


@end
