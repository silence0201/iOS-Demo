//
//  UIView+FrameChange.h
//  PresentOneControllerDemo
//
//  Created by 杨晴贺 on 04/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameChange)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign, readonly) CGFloat bottomFromSuperView;
@end
