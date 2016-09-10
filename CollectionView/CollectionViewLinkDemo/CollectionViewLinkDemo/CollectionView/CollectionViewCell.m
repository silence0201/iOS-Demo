//
//  CollectionViewCell.m
//  CollectionViewLinkDemo
//
//  Created by 杨晴贺 on 9/10/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Model.h"

@interface CollectionViewCell ()

@property (nonatomic,strong) UIImageView *imageV ;
@property (nonatomic,strong) UILabel *nameLabel ;

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.height - 4)] ;
        self.imageV.contentMode = UIViewContentModeScaleAspectFill ;
        [self.contentView addSubview:self.imageV] ;
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, self.frame.size.width + 2, self.frame.size.width-4, 20)] ;
        self.nameLabel.font = [UIFont systemFontOfSize:13] ;
        self.nameLabel.textAlignment = NSTextAlignmentCenter ;
        [self .contentView addSubview:self.nameLabel] ;
    }
    return self ;
}

- (void)setModel:(SubCategoryModel *)model{
    _model = model ;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.icon_url]] ;
    self.nameLabel.text = model.name ;
 }

@end
