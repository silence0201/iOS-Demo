//
//  SITabBarButton.m
//  TabbarDemo
//
//  Created by 杨晴贺 on 9/11/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SITabBarButton.h"

static NSInteger const kImageWidth = 22.5 ;

@interface SITabBarButton ()

@property (nonatomic,strong) UIButton *badgeButton ;

@end

@implementation SITabBarButton

#pragma mark - Init Method
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:13] ;
        self.titleLabel.textAlignment = NSTextAlignmentCenter ;
        [self.titleLabel sizeToFit] ;
        
        self.badgeButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        self.badgeButton.userInteractionEnabled = NO ;
        self.badgeButton.clipsToBounds = YES ;
        self.badgeButton.backgroundColor = [UIColor redColor] ;
        self.badgeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.badgeButton] ;
        self.badgeStyle = TabItemBadgeStyleNone ;
    }
    return self ;
}


#pragma mark - 设置外观

// 设置文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+5, self.frame.size.width, 13);
}

// 设置图片的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((self.frame.size.width - kImageWidth)/2, 8, kImageWidth, kImageWidth) ;
}

// 去除高亮状态
- (void)setHighlighted:(BOOL)highlighted{}


- (void)setIsHideBadgeBtn:(BOOL)isHideVadgeBtn{
    _isHideBadgeBtn = isHideVadgeBtn ;
    if(isHideVadgeBtn){
        self.badgeButton.hidden = YES ;
    }else{
        self.badgeButton.hidden = NO ;
    }
}

#pragma mark - 重写setter方法
- (void)setBadge:(NSInteger)badge{
    _badge = badge ;
    [self updateBadge] ;
}

- (void)setBadgeStyle:(TabItemBadgeStyle)badgeStyle{
    _badgeStyle = badgeStyle ;
    [self updateBadge] ;
}



#pragma mark - Update Badge
- (void)updateBadge{
    switch (self.badgeStyle) {
        case TabItemBadgeStyleNone:
            self.badgeButton.hidden = YES ;
            break;
        case TabItemBadgeStyleNumber:
            [self setTabItemBadgeStyleNumber] ;
            break ;
        case TabItemBadgeStyleDot:
            [self setTabItemBadgeStyleDot] ;
            break ;
    }
}

- (void)setTabItemBadgeStyleNumber{
    if(self.badge == 0){
        self.badgeButton.hidden = YES ;
        return ;
    }
    
    NSString *badgeStr = [NSString stringWithFormat:@"%ld",_badge ] ;
    if(self.badge > 99){
        badgeStr = @"99+" ;
    }else if (self.badge < -99){
        badgeStr = @"-99+" ;
    }
    
    // 计算badgeStr的Size
    CGSize size = [badgeStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:self.badgeButton.titleLabel.font}
                                         context:nil].size ;
    
    // 计算badgeButton的宽度和高度
    CGFloat width = ceilf(size.width) + 6 ;
    CGFloat height = ceilf(size.height) + 2 ;
    
    width = MAX(width, height);
    
    self.badgeButton.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) - width *0.5 +5, 2, width, height) ;
    self.badgeButton.layer.cornerRadius = self.badgeButton.bounds.size.height / 2 ;
    [self.badgeButton setTitle:badgeStr forState:UIControlStateNormal] ;
    self.badgeButton.hidden = NO ;
}

- (void)setTabItemBadgeStyleDot{
    [self.badgeButton setTitle:nil forState:UIControlStateNormal] ;
    self.badgeButton.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame), 5,10,10) ;
    self.badgeButton.layer.cornerRadius = self.badgeButton.bounds.size.height / 2 ;
    self.badgeButton.hidden = NO ;
}


@end
