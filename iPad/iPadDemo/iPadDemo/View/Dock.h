//
//  Dock.h
//  iPadDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomMenu.h"
#import "Tabbar.h"
#import "IconButton.h"

@protocol DockDelegate <NSObject>

@optional
- (void)bottomMenu:(BottomMenu *)bottomMenu withType:(BottomMenuType)type ;
- (void)tabbar:(Tabbar *)tabbar fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex ;
- (void)clickIconButton:(IconButton *)iconButtom ;

@end

@interface Dock : UIView

- (void)rolateToLandscape:(BOOL)isLandscape ;
- (void)unSelected ;

@property (nonatomic,weak) id<DockDelegate> delegate ;

@end
