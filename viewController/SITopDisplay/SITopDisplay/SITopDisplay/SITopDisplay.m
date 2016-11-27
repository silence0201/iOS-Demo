//
//  SITopDisplay.m
//  SITopDisplay
//
//  Created by 杨晴贺 on 27/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SITopDisplay.h"

@implementation SITopDisplay

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame withControl:YES] ;
}

- (instancetype)initWithFrame:(CGRect)frame topFrame:(CGRect)topFrame{
    if (self = [super initWithFrame:frame]) {
        [self setupTopDisplayControl:topFrame] ;
    }
    return self ;
}

- (instancetype)initWithFrame:(CGRect)frame withControl:(BOOL)haveControl{
    if (self = [super initWithFrame:frame]) {
        if (haveControl) {
            [self setupTopDisplayControl:CGRectMake(0,0,frame.size.width, 45)];
        }else{
            //内容视图
            _topDisplayContent = [[SITopDisplayContent alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, self.frame.size.height)] ;
            _topDisplayContent.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ;
            _topDisplayContent.backgroundColor = [UIColor clearColor] ;
            _topDisplayContent.dataSource = self ;
            [self addSubview:_topDisplayContent] ;
        }
    }
    return self ;
}

- (void)setupTopDisplayControl:(CGRect)frame{
    _topDisplayControl = [[SITopDisplayControl alloc]initWithFrame:frame] ;
    _topDisplayControl.dataSource = self ;
    
    _topDisplayControl.titleFont = [UIFont systemFontOfSize:16.0f] ;
    _topDisplayControl.selectedColor = [UIColor blackColor] ;
    [self addSubview:_topDisplayControl] ;
    
    _topDisplayContent = [[SITopDisplayContent alloc]initWithFrame:CGRectMake(0, frame.origin.y+frame.size.height, self.frame.size.width, self.frame.size.height-frame.origin.y-frame.size.height)] ;
    _topDisplayContent.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ;
    _topDisplayContent.backgroundColor = [UIColor clearColor] ;
    _topDisplayContent.dataSource = self ;
    [self addSubview:_topDisplayContent] ;
    
    _topDisplayContent.delegate = _topDisplayControl ;
    _topDisplayControl.delegate = _topDisplayContent ;
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont ;
    _topDisplayControl.titleFont = titleFont ;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex ;
    _topDisplayContent.selectedIndex = selectedIndex ;
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor ;
    _topDisplayControl.selectedColor = selectedColor ;
}

- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor ;
    _topDisplayControl.normalColor = normalColor ;
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage{
    _selectedBackgroundImage = selectedBackgroundImage ;
    _topDisplayControl.selectedBackgroundImage = selectedBackgroundImage ;
}

- (void)setUnSelectedBackgroundImage:(UIImage *)unSelectedBackgroundImage{
    _unSelectedBackgroundImage = unSelectedBackgroundImage ;
    _topDisplayControl.unSelectedBackgroundImage = unSelectedBackgroundImage ;
}

- (void)setMoveViewColor:(UIColor *)moveViewColor{
    _moveViewColor = moveViewColor ;
    _topDisplayControl.moveViewColor = moveViewColor ;
}

- (void)setDividLineColor:(UIColor *)dividLineColor{
    _dividLineColor = dividLineColor ;
    _topDisplayControl.dividLineColor = dividLineColor ;
}

#pragma mark -----菜单delegate
- (NSInteger)numberOfItemInTopDisplayControl:(SITopDisplayControl *)topDisplayControl{
    return [self.dataSource numberOfItemInTopDisplay:self] ;
}

- (CGFloat)widthForItemInTopDisplayControl:(SITopDisplayControl *)topDisplayControl index:(NSInteger)index{
    return [self.dataSource widthForItemInTopDisplay:self index:index] ;
}

- (NSString *)topDisplayControl:(SITopDisplayControl *)topDisplayControl titleForItemAtIndex:(NSInteger)index{
    return  [self.dataSource topDisplayControl:topDisplayControl titleForItemAtIndex:index] ;
}


- (void)topDisplayControl:(SITopDisplayControl *)topDisplayControl didSelectedAtIndex:(NSInteger)index{
    if([self.delegate respondsToSelector:@selector(topDisplayControl:didSelectedAtIndex:)]){
        [self.delegate topDisplayControl:topDisplayControl didSelectedAtIndex:index] ;
    }
}

#pragma mark 内容视图delegate
- (NSInteger)numberOfItemInTopDisplayContent:(SITopDisplayContent *)topDisplayContent{
    return [self.dataSource numberOfItemInTopDisplay:self] ;
}

- (UIView *)topDisplayContent:(SITopDisplayContent *)topDisplayContent viewForItemAtIndex:(NSInteger)index{
    return [self.dataSource topDisplayContent:topDisplayContent viewForItemAtIndex:index] ;
}

- (void)topDisplayContent:(SITopDisplayContent *)topDisplayContent didSelectAtIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(topDisplayContent:didSelectAtIndex:)]) {
        [self.delegate topDisplayContent:topDisplayContent didSelectAtIndex:index] ;
    }
}

- (void)selectedView:(UIView *)subView didSelectedAtIndex:(NSInteger)index{
    if([self.delegate respondsToSelector:@selector(selectedView:didSelectedAtIndex:)]){
        [self.delegate selectedView:subView didSelectedAtIndex:index] ;
    }
}


@end
