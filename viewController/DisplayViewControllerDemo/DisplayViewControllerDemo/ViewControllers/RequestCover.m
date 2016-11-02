//
//  RequestCover.m
//  DisplayViewControllerDemo
//
//  Created by 杨晴贺 on 02/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "RequestCover.h"

@implementation RequestCover

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 50)] ;
        label.text = @"正在加载中" ;
        label.center = self.center ;
        [self addSubview:label] ;
        self.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4]  ;
    }
    return self ;
}

@end
