//
//  CellFrameModel.m
//  DynamicCellDemo
//
//  Created by 杨晴贺 on 9/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CellFrameModel.h"
#import "CellModel.h"
#import "UIImageView+WebCache.h"

#define NameFont  [UIFont systemFontOfSize:14]
#define TextFont  [UIFont systemFontOfSize:15]

@implementation CellFrameModel

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attr = @{NSFontAttributeName: font} ;
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size ;
}

#pragma mark - 初始模型
- (void)setCellModel:(CellModel *)cellModel{
    _cellModel = cellModel ;
    CGFloat padding = 10 ;
    
    // icon
    CGFloat iconX = padding ;
    CGFloat iconY = padding ;
    CGFloat iconW = 30 ;
    CGFloat iconH = 30 ;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH) ;
    
    // name
    CGSize nameSize = [self sizeWithText:cellModel.name font:NameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)] ;
    CGFloat nameX = CGRectGetMaxX(_iconF)+padding ;
    CGFloat nameY = iconY + (iconH - nameSize.height) *0.5 ;
    _nameF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height) ;
    
    // text
    CGFloat textX = iconX ;
    CGFloat textY = CGRectGetMaxY(_iconF) + padding ;
    CGSize textSize=[self sizeWithText:self.cellModel.text font:TextFont maxSize:CGSizeMake(([UIScreen mainScreen].bounds.size.width)-2*textX, MAXFLOAT)];
    _textF =  CGRectMake(textX, textY, textSize.width, textSize.height) ;
    
    // picture
    if(self.cellModel.picture){
        CGFloat pictureX = textX ;
        CGFloat pictureY = CGRectGetMaxY(_textF) + padding ;
        CGFloat pictureWidth = cellModel.picWidth.floatValue ;
        CGFloat pictureHeight = cellModel.picHeight.floatValue ;
        _pictureF = CGRectMake(pictureX, pictureY, pictureWidth, pictureHeight) ;
        _cellHeight = CGRectGetMaxY(_pictureF) + padding ;
    }else{
        _cellHeight = CGRectGetMaxY(_textF) +padding ;
    }

}

@end
