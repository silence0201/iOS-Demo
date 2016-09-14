//
//  SICollectionViewCell.m
//  WaterFlowLayoutDemo
//
//  Created by 杨晴贺 on 9/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SICollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "DataModel.h"

@interface SICollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation SICollectionViewCell

- (void)setModel:(DataModel *)model{
    _model = model ;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.img]] ;
    self.label.text = model.title ;
}

@end
