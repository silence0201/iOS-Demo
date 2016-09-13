//
//  DynamicCell.m
//  DynamicCellDemo
//
//  Created by 杨晴贺 on 9/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "DynamicCell.h"
#import "CellFrameModel.h"
#import "CellModel.h"
#import "UIImageView+WebCache.h"


#define NameFont [UIFont systemFontOfSize:14]
#define TextFont [UIFont systemFontOfSize:15]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

NSString *const DynamicCellNotice = @"SelectionViewController" ;

@interface DynamicCell ()

@property (nonatomic,strong) UIImageView *iconView ;
@property (nonatomic,strong) UILabel *nameView ;
@property (nonatomic,strong) UILabel *textView ;
@property (nonatomic,strong) UIImageView *pictureView ;

@end

@implementation DynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconView = [[UIImageView alloc]init] ;
        [self.contentView addSubview:self.iconView] ;
        
        self.nameView = [[UILabel alloc]init] ;
        self.nameView.font = NameFont ;
        [self.contentView addSubview:self.nameView] ;
        
        self.textView = [[UILabel alloc]init] ;
        self.textView.numberOfLines = 0 ;
        self.textView.font = TextFont ;
        [self.contentView addSubview:self.textView] ;
        
        self.pictureView = [[UIImageView alloc]init] ;
        [self.contentView addSubview:self.pictureView] ;
    }
    return self ;
}

- (void)showCellWithModel:(CellFrameModel *)frameModel indexPath:(NSIndexPath *)indexPath{
    _frameModel = frameModel ;
    
    [self settingData:indexPath] ;
    
    [self settingFrame] ;
}

- (void)settingData:(NSIndexPath *)indexPath{
    CellModel *model = self.frameModel.cellModel ;
    self.iconView.image = [UIImage imageNamed:model.icon] ;
    self.nameView.text = model.name ;
    self.textView.text = model.text ;
    
    if(model.picture){
        self.pictureView.hidden = NO ;
        NSString *imageUrl = [NSString stringWithFormat:@"%@",model.picture] ;
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"img_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if ([model.picHeight isEqualToString:@"44"]) {
                CGFloat width = SCREEN_WIDTH - 20 ;
                CGFloat height = image.size.height * width / image.size.width ;
                NSDictionary * userInfo = @{
                                            @"Height" : @(height),
                                            @"Width":@(width),
                                            @"indexPath":indexPath};
                
                // 发送通知,更新cell的高度
                [[NSNotificationCenter defaultCenter] postNotificationName:DynamicCellNotice object:nil userInfo:userInfo];
            }
        }] ;
    }else{
        self.pictureView.hidden = YES ;
    }
}

- (void)settingFrame{
    self.iconView.frame = self.frameModel.iconF ;
    
    self.nameView.frame = self.frameModel.nameF ;
    
    self.textView.frame = self.frameModel.textF ;
    
    if (self.frameModel.cellModel.picture) {
        self.pictureView.frame = self.frameModel.pictureF ;
    }
}


@end
