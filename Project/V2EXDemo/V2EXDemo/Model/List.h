//
//  List.h
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List : NSObject

@property (nonatomic,copy) NSString *userAvatar;
@property (nonatomic,copy) NSString *replayUrl;
@property (nonatomic,copy) NSString *articleTitle;
@property (nonatomic,copy) NSString *nodeUrl;
@property (nonatomic,copy) NSString *nodeName;
@property (nonatomic,copy) NSString *userMember;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *createdDate;
@property (nonatomic,copy) NSString *lastReplayUserMember;
@property (nonatomic,copy) NSString *lastReplayUserName;
@property (nonatomic,copy) NSString *replayCount;

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
             replayCount:(NSString *)replayCount;

@end
