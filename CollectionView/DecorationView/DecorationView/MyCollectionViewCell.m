//
//  MyCollectionViewCell.m
//  DecorationView
//
//  Created by 杨晴贺 on 10/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell{
    UIImageView *_imageView ;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds] ;
        _imageView.image = [UIImage imageNamed:@"11"] ;
        _imageView.contentMode = UIViewContentModeScaleAspectFill ;
        _imageView.layer.cornerRadius = 6 ;
        _imageView.clipsToBounds = YES ;
        [self.contentView addSubview:_imageView] ;
    }
    return self ;
}

@end
