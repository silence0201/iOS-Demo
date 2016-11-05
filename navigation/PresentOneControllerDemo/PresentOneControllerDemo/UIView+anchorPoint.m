//
//  UIView+anchorPoint.h
//  PresentOneControllerDemo
//
//  Created by 杨晴贺 on 04/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UIView+anchorPoint.h"

@implementation UIView (anchorPoint)

- (void)setAnchorPointTo:(CGPoint)point{
    self.frame = CGRectOffset(self.frame, (point.x - self.layer.anchorPoint.x) * self.frame.size.width, (point.y - self.layer.anchorPoint.y) * self.frame.size.height);
    self.layer.anchorPoint = point;
}

@end
