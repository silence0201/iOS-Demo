//
//  NSString+TimeTamp.m
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSString+TimeTamp.h"

@implementation NSString (TimeTamp)

- (NSString *)toTimeTamp{
    NSString *time1970=[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    long nowDate=[time1970 longLongValue];
    long YDate=[self longLongValue];
    
    
    NSDateFormatter *formeter=[[NSDateFormatter alloc] init];
    [formeter setDateFormat:@"MM-dd HH:mm:ss"];
    
    
    int cha=(int)(nowDate-YDate);
    
    if (cha<60) {
        return @"刚刚";
    }else if(cha<60*60){
        NSString *str=[NSString stringWithFormat:@"%i分钟前",cha/60];
        return str;
    }else if(cha<60*60*24){
        NSString *str=[NSString stringWithFormat:@"%i小时前",cha/(60*60)];
        return str;
    }else if(cha<60*60*24*3){
        NSString *str=[NSString stringWithFormat:@"%i天前",cha/(60*60*24)];
        return str;
    }else{
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
        NSString *str=[formeter stringFromDate:date];
        return str;
    }
    
    return [NSString stringWithFormat:@"%i",cha];
}

@end
