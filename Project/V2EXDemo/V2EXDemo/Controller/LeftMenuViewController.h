//
//  LeftMenuViewController.h
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NodeSelectedDelegate <NSObject>

- (void)nodeSelectedCode:(NSString *)code Name:(NSString *)name Index:(NSInteger)index ;

@end

@interface LeftMenuViewController : UIViewController

@property (nonatomic,weak) id<NodeSelectedDelegate> delegate ;

@end
