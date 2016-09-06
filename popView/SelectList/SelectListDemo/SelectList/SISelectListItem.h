//
//  SISelectListItem.h
//  SelectListDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SISelectListItem : NSObject

/**
 *  图片对象
 */
@property (nonatomic,strong) UIImage *iconImage ;

/**
 *  显示标题
 */
@property (nonatomic,copy) NSString *title ;

/**
 *  简单构造函数
 *
 *  @param iconImage 图片
 *  @param title     标题
 *
 *  @return item对象
 */
- (instancetype)initWithIconImage:(UIImage *)iconImage andTitle:(NSString *)title ;

@end
