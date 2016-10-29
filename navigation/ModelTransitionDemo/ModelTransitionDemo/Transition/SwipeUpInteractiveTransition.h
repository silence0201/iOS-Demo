//
//  SwipeUpInteractiveTransition.h
//  ModelTransitionDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic,assign) BOOL interacting ;
- (void)writeToViewController:(UIViewController *)Vc ;

@end
