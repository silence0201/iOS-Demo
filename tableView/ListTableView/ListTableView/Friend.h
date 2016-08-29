//
//  Friend.h
//  ListTableView
//
//  Created by 杨晴贺 on 8/29/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

/**
 *  头像
 */
@property (nonatomic,copy) NSString *icon ;

/**
 *  个性签名
 */
@property (nonatomic,copy) NSString *intro ;

/**
 *  名称
 */
@property (nonatomic,copy) NSString *name ;

/**
 *  是否是会员
 */
@property (nonatomic,assign,getter=isVip) BOOL vip ;



+ (instancetype)friendWithDic:(NSDictionary *)dic ;
- (instancetype)initWithDic:(NSDictionary *)dic ;

@end
