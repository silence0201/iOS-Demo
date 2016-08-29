//
//  Friend.m
//  ListTableView
//
//  Created by 杨晴贺 on 8/29/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "Friend.h"

@implementation Friend

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic] ;
    }
    return self ;
}

+ (instancetype)friendWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic] ;
}

@end
