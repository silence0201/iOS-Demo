//
//  FriendGroup.h
//  ListTableView
//
//  Created by 杨晴贺 on 8/29/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendGroup : NSObject

/**
 *  分组的名称
 */
@property (nonatomic,copy) NSString *name ;

/**
 *  在线的人数
 */
@property (nonatomic,assign) NSInteger online ;

/**
 *  Friends
 */
@property (nonatomic,strong) NSMutableArray *friends ;

/**
 *  判断是否展开
 */
@property (nonatomic,assign,getter=isOpen) BOOL open ;

- (instancetype)initWithDic:(NSDictionary *)dic ;
+ (instancetype)groupWithDic:(NSDictionary *)dic ;
@end
