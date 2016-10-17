//
//  NSMutableArray+FilterElement.m
//  剧能玩2.1
//
//  Created by 大兵布莱恩特  on 15/11/11.
//  Copyright © 2015年 大兵布莱恩特 . All rights reserved.
//

#import "NSMutableArray+FilterElement.h"

@implementation NSMutableArray (FilterElement)
/**
 *   过滤掉相同的元素
 *
 *   @return 返回一个数组
 */
- (NSMutableArray*)filterTheSameElement
{
    NSMutableSet *set = [NSMutableSet set];
    for (NSObject *obj in self) {
        [set addObject:obj];
    }
    [self removeAllObjects];
    for (NSObject *obj in set) {
        [self addObject:obj];
    }
    return self;
}

@end
