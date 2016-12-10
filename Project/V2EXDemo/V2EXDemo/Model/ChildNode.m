//
//  ChildNode.m
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ChildNode.h"

@implementation ChildNode

- (instancetype)initWithChildNodeName:(NSString *)name CNode:(NSString *)code{
    if (self = [super init]) {
        self.childNodeCode = code ;
        self.childNodeName = name ;
    }
    return self ;
}

@end
