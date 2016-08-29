//
//  FriendGroup.m
//  ListTableView
//
//  Created by 杨晴贺 on 8/29/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "FriendGroup.h"
#import "Friend.h"

@implementation FriendGroup

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic] ;
        
        NSMutableArray *friends = [NSMutableArray array] ;
        
        for (NSDictionary *dic in self.friends) {
            Friend *friend = [Friend friendWithDic:dic] ;
            [friends addObject:friend] ;
        }
        self.friends = friends ;
    }
    return self ;
}

+ (instancetype)groupWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic] ;
}

@end
