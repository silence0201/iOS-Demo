//
//  CellModel.h
//  DynamicCellDemo
//
//  Created by 杨晴贺 on 9/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

@property (nonatomic,copy) NSString *text ;
@property (nonatomic,copy) NSString *icon ;
@property (nonatomic,copy) NSString *name ;
@property (nonatomic,copy) NSString *picture ;
@property (nonatomic,assign) BOOL vip ;

@property (nonatomic,copy) NSString *picWidth ;
@property (nonatomic,copy) NSString *picHeight ;

- (instancetype)initWithDic:(NSDictionary *)dic ;
+ (instancetype)modelWithDic:(NSDictionary *)dic ;

@end
