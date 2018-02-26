//
//  NSAttributedString+Extension.h
//  LiveRoomDemo
//
//  Created by Silence on 2018/2/26.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (Extension)

+ (NSAttributedString *)attributedStringWithStr:(NSString *)string anotherString:(NSString *)anotherStr andColor:(UIColor *)color;

@end
