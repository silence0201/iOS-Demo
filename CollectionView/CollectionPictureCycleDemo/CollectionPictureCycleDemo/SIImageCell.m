//
//  SIImageCell.m
//  CollectionPictureCycleDemo
//
//  Created by 杨晴贺 on 9/7/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SIImageCell.h"

@interface SIImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *indexView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@end

@implementation SIImageCell

- (void)awakeFromNib{
    // 设置总页数
    self.pageControl.numberOfPages = imageCount ;
    // 设置其他也得颜色
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor] ;
    // 设置当前页的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor] ;
    // 设置默认当前页
    self.pageControl.currentPage = 0 ;
}

// 重写imagePath属性的set方法来给子控件设置图片
- (void)setImagePath:(NSString *)imagePath{
    _imagePath = imagePath ;
    // 通过传过来的路径加载图片
    self.imageView.image = [UIImage imageNamed:imagePath] ;
    self.pageControl.currentPage = self.tag ;
}

- (void)setCurrentPath:(NSIndexPath *)currentPath{
    _currentPath = currentPath ;
    self.indexView.text = [NSString stringWithFormat:@"{%ld,%ld}",currentPath.section,currentPath.item] ;
}

@end
