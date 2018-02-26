//
//  NSAttributedString+Extension.m
//  LiveRoomDemo
//
//  Created by Silence on 2018/2/26.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

+ (NSAttributedString *)attributedStringWithStr:(NSString *)string anotherString:(NSString *)anotherStr andColor:(UIColor *)color{
    NSString *Str = [NSString stringWithFormat:@"%@  %@", string, anotherStr];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:Str];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, Str.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(Str.length - anotherStr.length, anotherStr.length)];
    return attributedStr;
}

@end
