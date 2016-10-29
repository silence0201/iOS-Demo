//
//  InteractionTransitionAnimation.h
//  NavigationTransitionAnimationDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InteractionTransitionAnimation : UIPercentDrivenInteractiveTransition

@property (nonatomic,assign) BOOL isActing ;

- (void)writeToViewController:(UIViewController *)toVc ;

@end
