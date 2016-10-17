//
//  PinYinForObjc.m
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import "PinYinForObjc.h"

@implementation PinYinForObjc

+ (NSString*)chineseConvertToPinYin:(NSString*)chinese {
    NSString *sourceText = chinese;
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *outputPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:sourceText withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    
    return outputPinyin;
    
    
}

+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese {
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSMutableString *outputPinyin = [[NSMutableString alloc] init];
    for (int i=0;i <chinese.length;i++) {
        NSString *mainPinyinStrOfChar = [PinyinHelper getFirstHanyuPinyinStringWithChar:[chinese characterAtIndex:i] withHanyuPinyinOutputFormat:outputFormat];
        if (nil!=mainPinyinStrOfChar) {
            [outputPinyin appendString:[mainPinyinStrOfChar substringToIndex:1]];
        }
    }
    // 如果是不是拼音需要判断到底是哪个英文开头的 如果数字特殊服的默认返回#
    if (outputPinyin.length==0) {
        outputPinyin = (NSMutableString*)[self englishToHeade:chinese];
    }
    
    return  [[outputPinyin substringToIndex:1] uppercaseString];
}

+ (NSString*)englishToHeade:(NSString*)string
{
    NSString *firstStr = [[string substringToIndex:1] uppercaseString];
    return [self isKindOfChar:firstStr]?firstStr:@"#";
}

+ (BOOL)isKindOfChar:(NSString*)str
{
    NSArray *array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"G",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    if ([array containsObject:str]) {
        return YES;
    }else{
        return NO;
    }
}
@end
