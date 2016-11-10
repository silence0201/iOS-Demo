//
//  CircleSpreadTransition.h
//  CircleSpreadDemo
//
//  Created by 杨晴贺 on 10/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,CircleSpreadTransitionType) {
    CircleSpreadTransitionTypePresent,
    CircleSpreadTransitionTypeDismiss
};

@interface CircleSpreadTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) CircleSpreadTransitionType type ;

- (instancetype)initWithTransitionType:(CircleSpreadTransitionType)type ;
+ (instancetype)transitionWithTransitionType:(CircleSpreadTransitionType)type ;

@end
