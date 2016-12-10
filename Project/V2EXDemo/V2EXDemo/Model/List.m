//
//  List.m
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "List.h"

@implementation List

- (instancetype)initWithUserAvatar:(NSString *)userAvatar
                         replayUrl:(NSString *)replayUrl
                      articleTitle:(NSString *)articleTitle
                           nodeUrl:(NSString *)nodeUrl
                          nodeName:(NSString *)nodeName
                        userMember:(NSString *)userMember
                          userName:(NSString *)userName
                       createdDate:(NSString *)createdDate
              lastReplayUserMember:(NSString *)lastReplayUserMember
                lastReplayUserName:(NSString *)lastReplayUserName
                       replayCount:(NSString *)replayCount{
    if (self = [super init]) {
        self.userAvatar = userAvatar ;
        self.replayUrl = replayUrl ;
        self.articleTitle = articleTitle ;
        self.nodeUrl = nodeUrl ;
        self.nodeName = nodeName ;
        self.userMember = userMember ;
        self.userName = userName ;
        self.createdDate = createdDate ;
        self.lastReplayUserMember = lastReplayUserMember ;
        self.lastReplayUserName = lastReplayUserName ;
        self.replayCount = replayCount ;
    }
    return self ;
}

@end
