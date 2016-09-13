//
//  ObjectFunction.h
//  新版本新功能测试
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 cheniue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ObjectFunction : NSObject
+(UIImage*)createBlurBackground:(UIImage*)image blurRadius:(CGFloat)blurRadius
;
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
;
@end
