//
//  ChildNode.h
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildNode : NSObject

@property (nonatomic,copy) NSString *childNodeName;
@property (nonatomic,copy) NSString *childNodeCode;

- (instancetype)initWithChildNodeName:(NSString *)name CNode:(NSString *)code;

@end
