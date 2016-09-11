//
//  SITabBar.h
//  TabbarDemo
//
//  Created by 杨晴贺 on 9/11/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SITabBarButton.h"

typedef void (^ClickBlock) (NSInteger index);
@interface SITabBar : UIView

@property (nonatomic,strong) NSArray *controllers;
@property (nonatomic,copy) NSArray<SITabBarButton *> *items ;
@property (nonatomic,copy) ClickBlock clickBlock ;

@end
