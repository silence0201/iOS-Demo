//
//  SearchResult.m
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SearchResult.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"

@implementation SearchResult
/**
 *  获取搜索的结果集
 *
 *  @param searchText 搜索内容
 *
 *  @return 返回结果集
 */
+ (NSMutableArray *)getSearchResultBySearchText:(NSString *)searchText dataArray:(NSMutableArray *)dataArray{
    NSMutableArray *searchResults = [NSMutableArray array];
    if (searchText.length>0 && ![ChineseInclude isIncludeChineseInString:searchText]) {
        for (int i=0; i<dataArray.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:dataArray[i]]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:dataArray[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:dataArray[i]];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                }
            }else {
                NSRange titleResult=[dataArray[i] rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                }
            }
        }
    } else if (searchText.length>0 && [ChineseInclude isIncludeChineseInString:searchText]) {
        for (NSString *tempStr in dataArray) {
            NSRange titleResult=[tempStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [searchResults addObject:tempStr];
            }
        }
    }
    return searchResults;
}
@end
