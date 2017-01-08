//
//  SIScratchView.m
//  ScratchViewDemo
//
//  Created by 杨晴贺 on 07/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "SIScratchView.h"
#import <QuartzCore/QuartzCore.h>


@implementation SIScratchView{
    NSMutableArray *rectArray ;
    NSMutableArray *passRectArray ;
    
    CGPoint previousTouchLocation ;
    CGPoint currentTouchLocation ;
    
    CGImageRef coveredImage ;
    CGImageRef scratchImage ;
    
    CGContextRef  maskContext ;
}

#pragma mark --- init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self defaultInit] ;
    }
    return self ;
}

- (void)defaultInit{
    self.opaque = NO ;
    // 设置默认值
    self.pathWidth = 10 ;
    self.maxPathCount = 10 ;
    rectArray = [NSMutableArray array] ;
    passRectArray = [NSMutableArray array] ;
    
    CGFloat rectWidth = self.bounds.size.width / 4 ;
    CGFloat rectHeight = self.bounds.size.height / 4 ;
    for (int i = 0; i < 4; i++) {
        for(int j = 0 ;j<4;j++){
            CGRect rect = CGRectMake(j * rectWidth, i * rectHeight, rectWidth, rectHeight) ;
            [rectArray addObject:[NSValue valueWithCGRect:rect]] ;
        }
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIImage *imageToDraw = [UIImage imageWithCGImage:scratchImage];
    [imageToDraw drawInRect:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
}

#pragma mark --- Set
- (void)setPathCount:(NSUInteger)pathCount{
    _pathCount = pathCount ;
    
    [rectArray removeAllObjects] ;
    CGFloat rectWidth = self.bounds.size.width / pathCount ;
    CGFloat rectHeight = self.bounds.size.height / pathCount ;
    for (int i = 0; i < pathCount; i++) {
        for(int j = 0 ;j< pathCount;j++){
            CGRect rect = CGRectMake(j * rectWidth, i * rectHeight, rectWidth, rectHeight) ;
            [rectArray addObject:[NSValue valueWithCGRect:rect]] ;
        }
    }
}


- (void)setCoveredView:(UIView *)coveredView{
    _coveredView = coveredView ;
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceGray();
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(coveredView.bounds.size, NO, 0);
    [coveredView.layer renderInContext:UIGraphicsGetCurrentContext()];
    coveredView.layer.contentsScale = scale;
    coveredImage = UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
    
    size_t imageWidth = CGImageGetWidth(coveredImage);
    size_t imageHeight = CGImageGetHeight(coveredImage);
    
    CFMutableDataRef pixels = CFDataCreateMutable(NULL, imageWidth * imageHeight);
    maskContext = CGBitmapContextCreate(CFDataGetMutableBytePtr(pixels), imageWidth, imageHeight , 8, imageWidth, colorspace, kCGImageAlphaNone);
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData(pixels);
    
    CGContextSetFillColorWithColor(maskContext, [UIColor blackColor].CGColor);
    CGContextFillRect(maskContext, self.frame);
    
    CGContextSetStrokeColorWithColor(maskContext, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(maskContext, self.pathWidth);
    CGContextSetLineCap(maskContext, kCGLineCapRound);
    
    CGImageRef mask = CGImageMaskCreate(imageWidth, imageHeight, 8, 8, imageWidth, dataProvider, nil, NO);
    scratchImage = CGImageCreateWithMask(coveredImage, mask);
    
    CGImageRelease(mask);
    CGColorSpaceRelease(colorspace);
}

#pragma mark --- Touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [[event touchesForView:self] anyObject];
    currentTouchLocation = [touch locationInView:self];
    [self recordPathRect:touches.anyObject];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [[event touchesForView:self] anyObject];
    if (!CGPointEqualToPoint(previousTouchLocation, CGPointZero)){
        currentTouchLocation = [touch locationInView:self];
    }
    previousTouchLocation = [touch previousLocationInView:self];
    [self scratchTheViewFrom:previousTouchLocation to:currentTouchLocation];
    [self recordPathRect:touches.anyObject];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [[event touchesForView:self] anyObject];
    if (!CGPointEqualToPoint(previousTouchLocation, CGPointZero)){
        previousTouchLocation = [touch previousLocationInView:self];
        [self scratchTheViewFrom:previousTouchLocation to:currentTouchLocation];
    }
    [self recordPathRect:touches.anyObject];
}

#pragma mark --- Private
- (void)scratchTheViewFrom:(CGPoint)startPoint to:(CGPoint)endPoint {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGContextMoveToPoint(maskContext, startPoint.x * scale, (self.frame.size.height - startPoint.y) * scale);
    CGContextAddLineToPoint(maskContext, endPoint.x * scale, (self.frame.size.height - endPoint.y) * scale);
    CGContextStrokePath(maskContext);
    [self setNeedsDisplay];
}

- (void)recordPathRect:(UITouch *)touch{
    CGPoint point =[touch locationInView:touch.view];
    // 遍历所有的区域,判断是否包含了点击的点
    for (int i=0; i < rectArray.count; i++) {
        CGRect rect = [rectArray[i] CGRectValue];
        if (CGRectContainsPoint(rect, point)) {
            if (![passRectArray containsObject:rectArray[i]]) {
                //把触摸到区域添加到数组
                [passRectArray addObject:rectArray[i]];
                //经过了一半的区域,则移除自身
                if (passRectArray.count > self.maxPathCount) {
                    [self dismiss];
                }
            }
            
        }
    }
}

- (void)dismiss {
    [self removeFromSuperview];
    [passRectArray removeAllObjects];
    if ([self.scratchViewDelegate respondsToSelector:@selector(scratchViewDidOpen:)]) {
        [self.scratchViewDelegate scratchViewDidOpen:self];
    }
    
}


@end
