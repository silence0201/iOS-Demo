//
//  SISelectListItem.m
//  SelectListDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SISelectListItem.h"

@implementation SISelectListItem

- (instancetype)initWithIconImage:(UIImage *)iconImage andTitle:(NSString *)title{
    if (self = [super init]) {
        self.iconImage = iconImage ;
        self.title = title ;
    }
    return self ;
}

@end
