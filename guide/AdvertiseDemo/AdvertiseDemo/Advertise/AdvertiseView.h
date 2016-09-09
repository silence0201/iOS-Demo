//
//  AdvertiseView.h
//  AdvertiseDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define User_Defaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"advertiseImageName";
static NSString *const adUrl = @"advertiseUrl";

@interface AdvertiseView : UIView

/**
 *  显示广告页面的方法
 */
- (void)show ;


/**
 * 图片路径
 */
@property (nonatomic,copy) NSString *filePath ;

/**
 *  图片显示时间长度
 */
@property (nonatomic,assign) NSInteger showTime ;


@end
