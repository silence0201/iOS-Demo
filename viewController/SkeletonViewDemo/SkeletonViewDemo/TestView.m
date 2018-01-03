//
//  TestView.m
//  SkeletonViewDemo
//
//  Created by Silence on 2018/1/3.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (NSArray<Skeleton *> *)skeletonLayout {
    Skeleton *s0 = [[Skeleton alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
    Skeleton *s1 = [[Skeleton alloc] initWithFrame:CGRectMake(90, 10, 130, 20)];
    Skeleton *s2 = [[Skeleton alloc] initWithFrame:CGRectMake(90, 50, 100, 20)];
    return @[s0,s1,s2];
}

@end
