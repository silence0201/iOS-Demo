//
//  CustomAlterView.h
//  CustomAlterView
//
//  Created by 杨晴贺 on 9/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  CustomAlterButtonDelegate <NSObject>

@optional
- (void)saveClickButton:(UIButton *)saveButton ;

@end

@interface CustomAlterView : UIView

@property (nonatomic,weak) id<CustomAlterButtonDelegate> buttonDelegate ;

- (void)show ;

@end
