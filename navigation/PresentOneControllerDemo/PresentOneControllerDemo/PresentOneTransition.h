//
//  PresentOneTransition.h
//  PresentOneControllerDemo
//
//  Created by 杨晴贺 on 05/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSUInteger,PresentOneTransitionStyle){
    PresentOneTransitionStylePresent = 0 ,
    PresentOneTransitionStyleDismiss
};

@interface PresentOneTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(PresentOneTransitionStyle)type;
- (instancetype)initWithTransitionType:(PresentOneTransitionStyle)type;

@end
