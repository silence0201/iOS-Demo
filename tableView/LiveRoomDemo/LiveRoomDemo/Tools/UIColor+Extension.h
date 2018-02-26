//
//  UIColor+Extension.h
//  LiveRoomDemo
//
//  Created by Silence on 2018/2/26.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ColorWithHex(Hex) [UIColor colorWithHexString:Hex]

#define kCColorZuHe                      @[ \
ColorWithHex(@"#ff4646"), \
ColorWithHex(@"#008aff"), \
ColorWithHex(@"#00dcd4"), \
ColorWithHex(@"#ffb900"), \
ColorWithHex(@"#ff5a23"), \
ColorWithHex(@"#ff66cc"), \
ColorWithHex(@"#33cc33"), \
ColorWithHex(@"#cc6633"), \
ColorWithHex(@"#9933cc"), \
ColorWithHex(@"#990000"), \
];

@interface UIColor (Extension)

+ (UIColor *)colorWithHexString:(NSString *)colorStr ;

@end
