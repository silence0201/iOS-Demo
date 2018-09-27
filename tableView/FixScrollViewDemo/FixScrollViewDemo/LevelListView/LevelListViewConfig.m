//
//  LevelListViewConfig.m
//  FixScrollViewDemo
//
//  Created by Silence on 2018/9/27.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "LevelListViewConfig.h"

@implementation LevelListViewConfig

- (instancetype)init{
    if (self = [super init]) {
        //配置初值
        self.titleFont = [UIFont systemFontOfSize:14];
        self.titleColorOfSelected = [UIColor orangeColor];
        self.titleColorOfUnSelected = [UIColor darkGrayColor];
        
        self.sizeOfImageView = CGSizeMake(15, 15);
        self.spacingOfTitleAndImage = 3.0f;
        
        self.heightOfUnderLineSelectedView = 3.0f;
        
        self.underLineViewColor = [UIColor groupTableViewBackgroundColor];
        self.heightOfUnderLineView = 1.0f;
        
        self.spacingOfSubView = 15.0f;
        self.marginOfSubView = 4.0f;
        
        self.backColor = [UIColor whiteColor];
        
        self.canRepeatTouch = NO;
        
        self.scrollAnimationType = LevelListScrollAnimationGradient;
    }
    return self;
}
- (void)setTitleColorOfSelected:(UIColor *)titleColorOfSelected {
    _titleColorOfSelected = titleColorOfSelected;
    self.underLineSelectedViewColor = titleColorOfSelected;
}
- (void)setImageInfoArr:(NSArray<id> *)imageInfoArr {
    _imageInfoArr = imageInfoArr;
    if (!self.imageInfoSelectedArr) {
        self.imageInfoSelectedArr = [imageInfoArr mutableCopy];
    }
}


@end
