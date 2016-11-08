//
//  ShopModel.m
//  ShopCartDemo
//
//  Created by 杨晴贺 on 08/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

- (instancetype)initWithShopDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic] ;
    }
    return self ;
}

+ (instancetype)shopWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithShopDic:dic] ;
}

@end
