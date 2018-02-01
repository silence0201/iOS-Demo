//
//  ViewController.m
//  NEStDemo
//
//  Created by Silence on 2018/2/1.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "SICommentController.h"
#import "SICatalogueController.h"
#import "SIIntroductionController.h"
#import "SIScrollView.h"
#import "SISegmentBar.h"

CGFloat const kheaderImgH = 210.0f;

@interface ViewController ()<UIScrollViewDelegate,SISegmentBarDeleggate,SIBaseTableViewControllerDelegate>{
    NSInteger _currentIndex;
}

@property (nonatomic,strong) SIScrollView *contentView;
@property (nonatomic,strong) UIImageView *header;
@property (nonatomic,strong) SISegmentBar *bar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课题";
    [self addChilds];
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.bar];
    [self.view addSubview:self.header];
    
    CGFloat navBarH = 44.0f + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.bounds.size.width, 0);
    self.header.frame = CGRectMake(0, navBarH, self.view.bounds.size.width, kheaderImgH);
    
    self.bar.frame = CGRectMake(0, navBarH+kheaderImgH, self.view.bounds.size.width, 44);
    
    // 选中第0个VC
    [self selectedIndex:0];
}

- (void)addChilds {
    [self addChildWithVC:[SIIntroductionController new] title:@"介绍"];
    [self addChildWithVC:[SICatalogueController new] title:@"目录"];
    [self addChildWithVC:[SICommentController new] title:@"评价"];
}
- (void)addChildWithVC:(UITableViewController *)vc title:(NSString *)title {
    vc.title = title;
    [self addChildViewController:vc];
}

//选中索引对应VC
- (void)selectedIndex:(NSInteger)index {
    UIViewController *VC = self.childViewControllers[index];
    if (!VC.view.superview) {
        VC.view.frame = CGRectMake(index * self.contentView.frame.size.width, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
        [self.contentView addSubview:VC.view];
    }
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.frame.size.width, 0) animated:NO];
    _currentIndex = index;
}

#pragma mark - UIScrollViewDelegate
// 滚动完成调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger i = offsetX / scrollView.frame.size.width;
    [self selectedIndex:i];
    self.bar.selectedIndex = i;
}
#pragma mark - XLSegmentBarDelegate

- (void)segmentBar:(SISegmentBar *)segmentBar selectedIndex:(NSInteger)index {
    [self selectedIndex:index];
}
#pragma mark - XLStudyChildVCDelegate
- (void)childVc:(SIBaseTableViewController *)childVc scrollViewDidScroll:(UIScrollView *)scroll {
    CGFloat offsetY = scroll.contentOffset.y;
    CGFloat navBarH = 44.0f + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    SIBaseTableViewController *currentVC = self.childViewControllers[_currentIndex];
    if ([currentVC isEqual:childVc]) {
        CGRect headerFrame = self.header.frame;
        headerFrame.origin.y = navBarH - offsetY;
        // header上滑到导航条位置时，固定
        if (headerFrame.origin.y <= -(kheaderImgH - navBarH)) {
            headerFrame.origin.y = -(kheaderImgH - navBarH);
        }
        // header向下滑动时，固定
        else if (headerFrame.origin.y >= navBarH) {
            headerFrame.origin.y = navBarH;
        }
        self.header.frame = headerFrame;
        
        CGRect barFrame = self.bar.frame;
        barFrame.origin.y = CGRectGetMaxY(self.header.frame);
        self.bar.frame = barFrame;
        
        // 改变其他VC中的scroll偏移
        [self.childViewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isMemberOfClass:[SIBaseTableViewController class]]) {
                SIBaseTableViewController *vc = (SIBaseTableViewController *)obj;
                [vc setCurrentScrollContentOffsetY:offsetY];
            }
        }];
    }
}

#pragma mark - lazy
- (SIScrollView *)contentView {
    if (!_contentView) {
        CGFloat navBarH = 44.0f + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        _contentView = [[SIScrollView alloc] initWithFrame:CGRectMake(0, navBarH, self.view.bounds.size.width, self.view.bounds.size.height-navBarH)];
        _contentView.delegate = self;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
    }
    return _contentView;
}

- (UIImageView *)header {
    if (!_header) {
        _header = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header.jpg"]];
        _header.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _header;
}

- (SISegmentBar *)bar {
    if (!_bar) {
        NSArray *titles = [self.childViewControllers valueForKey:@"title"];
        _bar = [[SISegmentBar alloc]initWithTitles:titles];
        _bar.delegate = self;
        _bar.backgroundColor = [UIColor whiteColor];
    }
    return _bar;
}


@end
