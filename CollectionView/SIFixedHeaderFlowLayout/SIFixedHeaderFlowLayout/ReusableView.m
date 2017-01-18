//
//  ReusableView.m
//  SIFixedHeaderFlowLayout
//
//  Created by 杨晴贺 on 18/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "ReusableView.h"

@implementation ReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        UILabel *label = [[UILabel alloc]initWithFrame:self.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

-(void)setText:(NSString *)text{
    _text = text;
    ((UILabel *)self.subviews[0]).text = text;
}


@end
