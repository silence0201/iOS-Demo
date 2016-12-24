//
//  UIScrollView+SIFlurryCover.h
//  FlurryCoverDemo
//
//  Created by 杨晴贺 on 24/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIFlurryCover.h"

@interface UIScrollView (SIFlurryCover)

@property(nonatomic,weak) SIFlurryCover *coverView;

- (void)addFlurryCoverWithImage:(UIImage*)image;
- (void)addFlurryCoverWithFrame:(CGRect)frame Image:(UIImage*)image  ;
- (void)removeFlurryCoverView;

@end
