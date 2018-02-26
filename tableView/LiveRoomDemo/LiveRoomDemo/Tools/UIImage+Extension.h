//
//  UIImage+Extension.h
//  LiveRoomDemo
//
//  Created by Silence on 2018/2/26.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)imageEffectLightFromImage:(UIImage *)inputImage;
+ (UIImage *)imageEffectExtraLightFromImage:(UIImage *)inputImage;
+ (UIImage *)imageEffectDarkFromImage:(UIImage *)inputImage;
+ (UIImage *)imageEffectTintFromImage:(UIImage *)inputImage andEffectColor:(UIColor *)tintColor;

@end
