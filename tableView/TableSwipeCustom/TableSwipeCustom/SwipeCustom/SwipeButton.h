//
//  SwipeButton.h
//  TableSwipeCustom
//
//  Created by 杨晴贺 on 20/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchSwipeButtonBlock)();

@interface SwipeButton : UIButton

@property(nonatomic,strong) TouchSwipeButtonBlock touchBlock ;

/**
 *  快速构造
 *
 */
+ (SwipeButton *)createSwipeButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor touchBlock:(TouchSwipeButtonBlock)block;

+ (SwipeButton *)createSwipeButtonWithTitle:(NSString *)title font:(CGFloat)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor touchBlock:(TouchSwipeButtonBlock)block;

+ (SwipeButton *)createSwipeButtonWithImage:(UIImage *)image backgroundColor:(UIColor *)color touchBlock:(TouchSwipeButtonBlock)block;

+ (SwipeButton *)createSwipeButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image touchBlock:(TouchSwipeButtonBlock)block;


/**
 *  全能构造
 */
+ (SwipeButton *)createSwipeButtonWithTitle:(NSString *)title font:(CGFloat)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image touchBlock:(TouchSwipeButtonBlock)block;

@end
