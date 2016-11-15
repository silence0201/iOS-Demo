//
//  CitySelectView.h
//  SelectCityDemo
//
//  Created by 杨晴贺 on 15/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSString *proviceStr,NSString *cityStr,NSString *disStr) ;

@interface CitySelectView : UIView

- (instancetype)initWithFrame:(CGRect)frame withSelectCityTitle:(NSString *)title ;

- (void)showCityView:(ClickBlock)clickBlock ;

@end
