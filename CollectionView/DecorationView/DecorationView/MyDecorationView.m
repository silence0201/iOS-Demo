//
//  MyDecorationView.m
//  DecorationView
//
//  Created by 杨晴贺 on 10/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "MyDecorationView.h"

@implementation MyDecorationView{
    UIImageView *_imageView ;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds] ;
        _imageView.image = [UIImage imageNamed:@"background"] ;
        [self addSubview:_imageView] ;
    }
    return self ;
}

@end
