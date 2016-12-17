//
//  IconButton.m
//  iPadDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "IconButton.h"

@implementation IconButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"简单" forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"Easy"] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self ;
}

- (void)rolateToLandscape:(BOOL)isLandscape{
    self.width = isLandscape ? kIconButtonLandscapeWidth : kIconButtonPortraitWH;
    self.height = isLandscape ? kIconButtonLandscapeHeight : kIconButtonPortraitWH;
    self.top = kIconButtonY;
    self.left = (self.superview.width - self.width) * 0.5;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (self.width == self.height) { // 竖屏
        return CGRectMake(0, 0, -1, -1);
    } else { // 横屏
        CGFloat width = self.width;
        CGFloat height = kIconButtonTitleHeight;
        CGFloat x = 0;
        CGFloat y = self.width;
        return CGRectMake(x, y, width, height);
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.width == self.height) { // 竖屏
        return self.bounds;
    } else { // 横屏
        CGFloat width = self.width;
        CGFloat height = self.width;
        CGFloat x = 0;
        CGFloat y = 0;
        return CGRectMake(x, y, width, height);
    }
}
@end
