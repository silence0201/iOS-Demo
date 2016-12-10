//
//  Node.m
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)initWithNodeName:(NSString *)name NodeCode:(NSString *)code{
    if (self = [super init]) {
        self.nodeName = name ;
        self.nodeCode = code ;
    }
    return self ;
}

@end
