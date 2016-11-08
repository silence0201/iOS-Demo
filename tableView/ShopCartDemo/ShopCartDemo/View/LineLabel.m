//
//  LineLabel.m
//  ShopCartDemo
//
//  Created by 杨晴贺 on 08/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "LineLabel.h"

@interface LineLabel (){
    CGRect labelFrame ;
}

@end

@implementation LineLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        labelFrame = frame ;
    }
    return self ;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect] ;
    if (_color) {
        _color = [UIColor grayColor] ;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext() ;
    CGContextBeginPath(context) ;
    CGContextSetLineWidth(context, 0.5) ;
    CGContextSetStrokeColorWithColor(context, _color.CGColor) ;
    CGContextMoveToPoint(context, 0, labelFrame.size.height / 2.0) ;
    CGContextAddLineToPoint(context, rect.size.width, labelFrame.size.height/2.0) ;
    CGContextDrawPath(context, kCGPathEOFillStroke) ;
}

@end
