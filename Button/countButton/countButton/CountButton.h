//
//  CountButton.h
//  countButton
//
//  Created by 杨晴贺 on 8/30/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickButtonAction)() ;

@interface CountButton : UIButton

@property (nonatomic,assign) NSInteger second ;  // 倒计时的秒数

@property (nonatomic,copy) ClickButtonAction clickButtonAction ;   // 点击事件

@end
