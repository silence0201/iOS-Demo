//
//  CollectionViewCell.m
//  LongDeleteCollectionView
//
//  Created by 杨晴贺 on 9/8/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor] ;
        self.imageView = [[UIImageView alloc]init] ;
        self.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH / 3.0, SCREEN_WIDTH / 3.0) ;
        [self.contentView addSubview:self.imageView] ;
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        self.btn.frame = CGRectMake(0, 0, 20, 20) ;
        [self.btn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal] ;
        self.btn.hidden = YES ;
        [self.btn addTarget:self action:@selector(deletBtnClick) forControlEvents:UIControlEventTouchUpInside] ;
        [self.contentView addSubview:_btn] ;
        
        // 长按手势
        UILongPressGestureRecognizer *lg = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longClick:)] ;
        [self addGestureRecognizer:lg] ;
        
        // 点击手势
        UITapGestureRecognizer *singtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)] ;
        [singtap setNumberOfTapsRequired:1] ;
        [self.imageView addGestureRecognizer:singtap] ;
        
        
    }
    return self ;
}

#pragma mark - Action
// 单击手势
- (void)handleSingleTap:(UITapGestureRecognizer *)tap{
    if([self.delegate respondsToSelector:@selector(hideAllDeleteBtn)]){
        [self.delegate hideAllDeleteBtn] ;
    }
}

// 长按手势
- (void)longClick:(UILongPressGestureRecognizer *)longGesture{
    if([self.delegate respondsToSelector:@selector(showAllDeleteBtn)]){
        [self.delegate showAllDeleteBtn] ;
    }
}

// 删除按钮操作
- (void)deletBtnClick{
    if([self.delegate respondsToSelector:@selector(deleteCellAtIndexPath:)]){
        [self.delegate deleteCellAtIndexPath:self.path] ;
    }
}




@end
