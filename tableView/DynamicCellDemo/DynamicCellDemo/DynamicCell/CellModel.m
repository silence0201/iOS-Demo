//
//  CellModel.m
//  DynamicCellDemo
//
//  Created by 杨晴贺 on 9/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

#pragma mark - init
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic] ;
        if(self.picture){
            [self setValue:@"44" forKey:@"picWidth"] ;
            [self setValue:@"44" forKey:@"picHeight"] ;
        }
    }
    return self ;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic] ;
}

@end
