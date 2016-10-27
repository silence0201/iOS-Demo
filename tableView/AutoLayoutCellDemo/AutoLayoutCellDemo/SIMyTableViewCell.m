//
//  SIMyTableViewCell.m
//  AutoLayoutCellDemo
//
//  Created by 杨晴贺 on 27/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SIMyTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface SIMyTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descTopConstraint;


@end

@implementation SIMyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark --  写入模型
- (void)setModel:(SIModel *)model{
    _model = model ;
    
    // 设置界面
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.headImageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            self.headerImageView.alpha = 0 ;
            [UIView animateWithDuration:1.0 animations:^{
                self.headerImageView.alpha = 1 ;
            }] ;
        }else{
            self.headerImageView.alpha = 1 ;
        }
    }] ;
    
    self.titleLabel.text = model.userName ;
    self.descLabel.text = model.desc ;
    // 当图片存在时
    if(![model.mainImageURL isEqualToString:@""]){
        self.mainImageView.hidden = NO ;
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.mainImageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image && cacheType == SDImageCacheTypeNone) {
                self.mainImageView.alpha = 0 ;
                [UIView animateWithDuration:1.0 animations:^{
                    self.mainImageView.alpha = 1 ;
                }] ;
            }else{
                self.mainImageView.alpha = 1 ;
            }
        }] ;
        
        self.mainHeightConstraint.constant = (model.mainHeight * [UIScreen mainScreen].bounds.size.width) / model.mainWidth ;
        self.descTopConstraint.constant = 8 ;
    }else{
        // 没有图片
        self.mainImageView.hidden = YES ;
        self.mainHeightConstraint.constant = 0 ;
        self.descTopConstraint.constant = 0 ;
    }
}


@end
