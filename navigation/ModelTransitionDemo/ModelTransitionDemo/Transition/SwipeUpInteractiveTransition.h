//
//  SwipeUpInteractiveTransition.h
//  ModelTransitionDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition

// 是否在过程中
@property (nonatomic,assign) BOOL interacting ;

// 设置对应的ViewController
- (void)writeToViewController:(UIViewController *)Vc ;

@end
