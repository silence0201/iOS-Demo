//
//  MyView.m
//  CollectionMirror
//
//  Created by 杨晴贺 on 9/8/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MyView.h"

@implementation MyView

+ (Class)layerClass{
    return [CAReplicatorLayer class] ;
}

- (void)setInverterImage{
    CGFloat height = self.bounds.size.height ;
    CGFloat contractRate = 0.5f ;   // 收缩比例
    
    /*
     参数一：x轴缩放
     参数二：Y轴缩放
     参数三：当 x = y, z>0,图形缩小， 0-1，图形变大， <0,远点对称等比变换
     */
    CATransform3D t = CATransform3DMakeScale(1, -contractRate, -1) ;
    /*
     c0: 上面的参数
     c1：X轴偏移位置，往右为正。
     c2：Y轴偏移位置，往上为正数。
     c3：Z轴偏移位置，往外为正数，表示越大越接近屏幕
     */
    t = CATransform3DTranslate(t, 0, -1.6*height, 0) ;
    CAReplicatorLayer *replcatorLayer = (CAReplicatorLayer *)self.layer; ;
    replcatorLayer.instanceTransform = t;
    replcatorLayer.instanceCount = 2; //layer和一个副本laye
    replcatorLayer.instanceRedOffset = -0.5; //将rgb的三色值缩小0.5
    replcatorLayer.instanceGreenOffset = -0.5;
    replcatorLayer.instanceBlueOffset = -0.5;
}

@end
