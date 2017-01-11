//
//  PhotoCell.m
//  CustomFlowLayoutDemo
//
//  Created by 杨晴贺 on 11/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PhotoCell
- (void)awakeFromNib {
    [super awakeFromNib] ;
    _imageView.contentMode = UIViewContentModeScaleAspectFill ;
    _imageView.layer.cornerRadius = 6 ;
    _imageView.layer.masksToBounds = YES ;
}

- (void)setImageName:(NSString *)imageName{
    _imageName = [imageName copy];
    self.imageView.image = [UIImage imageNamed:imageName];
}
@end
