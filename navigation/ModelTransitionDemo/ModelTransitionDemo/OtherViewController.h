//
//  OtherViewController.h
//  ModelTransitionDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)() ;

@interface OtherViewController : UIViewController

@property (nonatomic,copy) ClickBlock clickBlock;

@end
