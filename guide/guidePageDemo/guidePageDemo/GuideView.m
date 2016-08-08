//
//  GuideView.m
//  guidePageDemo
//
//  Created by 杨晴贺 on 8/8/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "GuideView.h"


@interface GuideView ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollView ;  // 滚动页面
@property (nonatomic,strong) NSMutableArray *imageArray ;  // 图片数组
@property (nonatomic,weak) UIPageControl *pageController ; //分页控制器
//{
//    UIScrollView    *_scrollView;
//    NSMutableArray  *_imageArray;
//    UIPageControl   *_pageController;
//}

@end

@implementation GuideView

// 代码初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageArray = [@[@"guide1.png",@"guide2.png",@"guide3.png",@"guide4.png",@"guide5.png"] mutableCopy] ;
        // 初始化
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)] ;
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (_imageArray.count+1), SCREEN_HEIGHT) ;
        // 设置反弹效果
        scrollView.pagingEnabled = YES ; //设置分页
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO ;
        scrollView.delegate = self ;
        _scrollView = scrollView ;
        [self addSubview:_scrollView] ;
        
        // 添加UIImageView
        for(NSInteger i = 0 ; i < _imageArray.count ; i++){
            UIImageView *imageView = [[UIImageView alloc]init] ;
            imageView.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT) ;
            UIImage *image = [UIImage imageNamed:_imageArray[i]] ;
            imageView.image = image ;
            [scrollView addSubview:imageView] ;
        }
        
        // 初始化分页控制器
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 60, 0, 40)] ;
        pageControl.numberOfPages = _imageArray.count ;
        pageControl.backgroundColor = [UIColor clearColor] ;
        [self addSubview:pageControl] ;
        
        _pageController = pageControl ;
        
        // 添加手势
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)] ;
        gesture.numberOfTapsRequired = 1 ;
        [scrollView addGestureRecognizer:gesture] ;
    }
    
    return self ;
}

#pragma mark - 手势Action
- (void)hideView{
    if (_pageController.currentPage == [_imageArray count]) {
        self.hidden = YES ;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        CGPoint offSet = scrollView.contentOffset ;
        
        _pageController.currentPage = offSet.x / SCREEN_WIDTH ;  // 计算当前的页码
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _pageController.currentPage, 0) animated:YES] ;
    }
    
    if (scrollView.contentOffset.x == _imageArray.count * SCREEN_WIDTH) {
        self.hidden = YES ;
    }
}

@end
