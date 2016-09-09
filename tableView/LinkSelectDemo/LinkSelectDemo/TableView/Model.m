//
//  Model.m
//  LinkSelectDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "Model.h"

@implementation CategoryModel

+ (NSDictionary *)objectClassInArray
{
    return @{ @"spus": @"FoodModel" };
}

@end

@implementation FoodModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"foodId": @"id" };
}

@end
