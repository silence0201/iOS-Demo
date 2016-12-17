//
//  BottomMenu.h
//  iPadDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BottomMenu ;

typedef enum{
    BottomMenuTypeMood,
    BottomMenuTypePhoto,
    BottomMenuTypeBlog
}BottomMenuType;

@protocol BottomMenuDelegate <NSObject>

@optional
- (void)bottomMenu:(BottomMenu *)bottomMenu withType:(BottomMenuType)type ;

@end

@interface BottomMenu : UIView

- (void)rolateToLandscape:(BOOL)isLandscape ;

@property (nonatomic,weak) id<BottomMenuDelegate> delegate ;

@end
