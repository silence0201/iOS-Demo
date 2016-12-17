//
//  Tabbar.h
//  iPadDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tabbar ;

@protocol TabbarDelegate <NSObject>

@optional
- (void)tabbar:(Tabbar *)tabbar fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex ;

@end

@interface Tabbar : UIView

@property (nonatomic,weak) id<TabbarDelegate> delegate ;

- (void)unSelected ;

- (void)rolateToLandscape:(BOOL)isLandscape ;

@end

@interface TabbarItem : UIButton

@end
