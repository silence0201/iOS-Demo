//
//  Node.h
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic,copy) NSString *nodeName;
@property (nonatomic,copy) NSString *nodeCode;
@property (nonatomic,copy) NSArray *childNodeArray;

- (instancetype)initWithNodeName:(NSString *)name NodeCode:(NSString *)code ;

@end
