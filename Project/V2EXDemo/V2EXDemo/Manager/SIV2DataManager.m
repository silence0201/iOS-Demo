//
//  SIV2DataManager.m
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SIV2DataManager.h"

#import "NSString+TimeTamp.h"

#import "TFHpple.h"

#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"
#import "Reachability.h"

#import "List.h"
#import "Replay.h"

@implementation SIV2DataManager{
    BOOL isRequestChildNode ;
    NSString *_childNodeName ;
}

#pragma mark --- 单例
+ (instancetype)shareManager{
    static SIV2DataManager *manager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SIV2DataManager alloc]init] ;
        manager.baseUrl = @"https://v2ex.com" ;
    });
    return manager ;
}


#pragma mark --- Request
- (void)getArticleListWithNodeCode:(NSString *)code
                          codeName:(NSString *)name
                      requestChild:(BOOL)child
                              Page:(NSInteger)page
                           isCache:(BOOL)cache
                    isStorageCache:(BOOL)storageCache
                   V2RequestPolicy:(SIV2RequestPolicy)policy
                           Success:(void (^)(NSArray *))success
                           failure:(void (^)(NSError *))failure{
    _childNodeName = name ;
    // 是否加载子节点
    isRequestChildNode = child ;
    
    NSURL *url ;
    if (isRequestChildNode) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/go/%@?p=%li",_baseUrl,code,page]] ;
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?tab=%@",_baseUrl,code]] ;
    }
    
    // request
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url] ;
    
    // 是否使用缓存
    if(cache){
        [request setDownloadCache:[ASIDownloadCache sharedCache]] ;
    }
    
    // 设置请求超时时间
    request.timeOutSeconds = 30 ;
    
    // 超时后重复次数
    request.numberOfTimesToRetryOnTimeout = 1 ;
    
    // 开启请求
    [request startAsynchronous] ;
    
    // 设置缓存策略
    switch (policy) {
        case SIV2RequestFallUseCache:
            [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy] ;
            break;
        case SIV2RequestAskServerIsUserCache:
            [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
            break;
        case SIV2RequestOnlyUseCache:
            [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
            break;
        default:
            [request setCachePolicy:ASIUseDefaultCachePolicy] ;
            break;
    }
    
    // 是否将数据永久保存到本地
    storageCache ? [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy] : NO ;
    
    // 设置是否按服务器在Header里指定的是否可被缓存或过期策略进行缓存
    [[ASIDownloadCache sharedCache ] setShouldRespectCacheControlHeaders:NO] ;
    
    // 设置request缓存的有效时间
    [request setSecondsToCache:60*60*24*30] ;
    
    // 回调
    __block ASIHTTPRequest *blockRequest = request ;
    __block SIV2DataManager *manager = self ;
    
    [request setCompletionBlock:^{
         success([manager htmlDataToObject:blockRequest.responseData]) ;
    }] ;
    
    [request setFailedBlock:^{
        failure(blockRequest.error) ;
    }] ;
}

- (NSArray *)htmlDataToObject:(NSData *)data{
    TFHpple *htmParser = [[TFHpple alloc]initWithHTMLData:data] ;
    
    NSArray *htmlElements ;
    if (isRequestChildNode) {
        htmlElements = [htmParser searchWithXPathQuery:@"//div[@class='cell']"] ;
    }else{
        htmlElements = [htmParser searchWithXPathQuery:@"//div[@class='cell item']"] ;
    }
    
    NSMutableArray *articleDataArray = [NSMutableArray array] ;
    for(TFHppleElement *element in htmlElements){
        // avatar
        NSArray *avatars = [element searchWithXPathQuery:@"//img[@class='avatar']"] ;
        NSString *avatar = [avatars.firstObject objectForKey:@"src"] ;
        
        // title
        NSArray *titles = [element searchWithXPathQuery:@"//span[@class='item_title']/a]"] ;
        NSString *titleURL = [titles.firstObject objectForKey:@"href"] ;
        NSString *titleContent = [titles.firstObject content] ;
        
        // node
        NSArray *nodes = [element searchWithXPathQuery:@"//a[@class='node']"] ;
        NSString *nodeURL ;
        NSString *nodeName ;
        if(isRequestChildNode){
            nodeName = _childNodeName ;
            nodeURL = @"" ;
        }else{
            nodeURL = [nodes.firstObject objectForKey:@"href"] ;
            nodeName = [nodes.firstObject content] ;
        }
        
        // user
        NSArray *users ;
        NSString *userMember ;
        NSString *userName ;
        if (isRequestChildNode) {
            users = [element searchWithXPathQuery:@"//strong"] ;
            userMember = @"" ;
            userName = [users.firstObject content] ;
        }else{
            users = [element searchWithXPathQuery:@"//strong/a"] ;
            userMember = [users.firstObject objectForKey:@"href"] ;
            userName = [users.firstObject content] ;
        }
        
        // date
        NSArray *dates = [element searchWithXPathQuery:@"//span[@class='small fade']"] ;
        
        NSString *dateStr ;
        if(isRequestChildNode){
            if([[dates.firstObject content] componentsSeparatedByString:@"•"].count == 3){
                dateStr = [[dates.firstObject content]componentsSeparatedByString:@"•"][2] ;
            }else{
                dateStr = [[dates.firstObject content] componentsSeparatedByString:@"•"][1] ;
            }
        }else{
            dateStr = [[dates[1] content]componentsSeparatedByString:@"•"][0] ;
        }
        
        NSString *dd = [dateStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // last
        NSString *lastHref ;
        NSString *lastName ;
        if (dates.count == 2) {
            lastHref = [dates.firstObject objectForKey:@"href"] ;
            lastName = [dates.firstObject content] ;
        }else{
            lastHref = @"" ;
            lastName = @"" ;
        }
        
        // replay
        NSArray *replays = [element searchWithXPathQuery:@"//a[@class='count_livid']"] ;
        NSString *replay ;
        if (replays.count == 1) {
            replay = [replays.firstObject content] ;
        }else{
            replay = @"0" ;
        }
        
        // 格式化相应对象
        List *list = [[List alloc]initWithUserAvatar:avatar
                                           replayUrl:titleURL
                                        articleTitle:titleContent 
                                             nodeUrl:nodeURL 
                                            nodeName:nodeName
                                          userMember:userMember
                                            userName:userName
                                         createdDate:dd
                                lastReplayUserMember:lastHref
                                  lastReplayUserName:lastName
                                         replayCount:replay] ;
        
        [articleDataArray addObject:list] ;
    }
    return articleDataArray ;
}

- (void)getArticleContentWithPID:(NSString *)pid
                         Success:(void (^)(NSArray *))success
                         failure:(void (^)(NSError *))failure{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/topics/show.json?id=%@",_baseUrl,pid]] ;
    
    [ASIHTTPRequest setDefaultCache:[ASIDownloadCache sharedCache]] ;
    ASIHTTPRequest *request =[ASIHTTPRequest requestWithURL:url] ;
    request.timeOutSeconds=10 ;
    request.numberOfTimesToRetryOnTimeout=1 ;
    
    [request startAsynchronous] ;
    [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy] ;
    [[ASIDownloadCache sharedCache ] setShouldRespectCacheControlHeaders:NO];
    [request setSecondsToCache:60*60*24*30];
    
    __block ASIHTTPRequest *blockReques = request ;
    __block SIV2DataManager *manager = self ;
    
    [request setCompletionBlock:^{
        success([manager contentDataArr:blockReques.responseData]) ;
    }] ;
    
    [request setCompletionBlock:^{
        failure(blockReques.error) ;
    }] ;
    
    
}

- (NSArray *)contentDataArr:(NSData *)data{
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] ;
    
    NSDictionary *dic = [arr firstObject] ;
    NSString *content = [dic objectForKey:@"content"];
    NSString *timeStr = [NSString stringWithFormat:@"%li",[dic[@"created"] longValue]] ;
    NSString *createdTime = [timeStr toTimeTamp] ;
    return @[content,createdTime] ;
}

- (void)getArticleReplayListWithPID:(NSString *)pid
                            Success:(void (^)(NSArray *))success
                            failure:(void (^)(NSError *))failure{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/replies/show.json?topic_id=%@",_baseUrl,pid]] ;
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url] ;
    [request setDownloadCache:[ASIDownloadCache sharedCache]] ;
    request.timeOutSeconds = 20 ;
    request.numberOfTimesToRetryOnTimeout = 1 ;
    [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy] ;
    [[ASIDownloadCache sharedCache ] setShouldRespectCacheControlHeaders:NO];
    
    [request startAsynchronous] ;
    
    __block ASIHTTPRequest *blockRequest = request;
    __block SIV2DataManager  *manager = self;
    
    [request setCompletionBlock:^{
        success([manager replayDataToObject:blockRequest.responseData]) ;
    }] ;
    
    [request setFailedBlock:^{
        failure(blockRequest.error) ;
    }] ;
    
}

- (NSArray *)replayDataToObject:(NSData *)data{
    NSMutableArray *infoDataArr = [NSMutableArray array] ;
    NSArray *replayDataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] ;
    
    for(NSDictionary *dic in replayDataArr){
        Replay *replay = [[Replay alloc]init] ;
        replay.memberName = dic[@"member"][@"username"] ;
        replay.memberAvatar = dic[@"member"][@"avatar_normal"] ;
        replay.replayContent = dic[@"content"] ;
        replay.replayDate = [NSString stringWithFormat:@"%li",[dic[@"created"] longValue]] ;
        [infoDataArr addObject:replay] ;
    }
    return infoDataArr ;
}

@end
