//
//  SIV2DataManager.h
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,SIV2RequestPolicy) {
    SIV2RequestFallUseCache,
    SIV2RequestAskServerIsUserCache,
    SIV2RequestOnlyUseCache
};

@interface SIV2DataManager : NSObject

@property (nonatomic,copy) NSString *baseUrl ;

+ (instancetype)shareManager ;

#pragma mark --- Request

- (void)getArticleListWithNodeCode:(NSString *)code
                          codeName:(NSString *)name
                      requestChild:(BOOL)child
                              Page:(NSInteger)page
                           isCache:(BOOL)cache
                    isStorageCache:(BOOL)storageCache
                   V2RequestPolicy:(SIV2RequestPolicy )policy
                           Success:(void (^)(NSArray *listArray))success
                           failure:(void (^)(NSError *error))failure;

- (void)getArticleReplayListWithPID:(NSString *)pid
                            Success:(void (^)(NSArray *listArray))success
                            failure:(void (^)(NSError *error))failure;

- (void)getArticleContentWithPID:(NSString *)pid
                         Success:(void (^)(NSArray *contentArr))success
                         failure:(void (^)(NSError *error))failure;

@end
