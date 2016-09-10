//
//  CollectionViewHeaderView.m
//  CollectionViewLinkDemo
//
//  Created by 杨晴贺 on 9/10/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CollectionViewHeaderView.h"

@implementation CollectionViewHeaderView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = rgba(240, 240, 240, 0.8) ;
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH-80, 20) ];
        self.titleLabel.font = [UIFont systemFontOfSize:14] ;
        self.titleLabel.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:self.titleLabel] ;
    }
    return self ;
}

@end
