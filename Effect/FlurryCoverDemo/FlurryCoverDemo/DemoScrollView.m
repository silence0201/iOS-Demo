//
//  DemoScrollView.m
//  FlurryCoverDemo
//
//  Created by 杨晴贺 on 24/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "DemoScrollView.h"
#import "UIScrollView+SIFlurryCover.h"

@implementation DemoScrollView{
    UIScrollView *_scrollView ;
}

- (void)viewDidLoad{
    [super viewDidLoad] ;
    
    self.title = NSStringFromClass([self class]) ;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    
    self.view.backgroundColor = [UIColor whiteColor] ;
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds] ;
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1000)] ;
    [_scrollView addFlurryCoverWithImage:[UIImage imageNamed:@"cover"]] ;
    [self.view addSubview:_scrollView] ;
    
    [_scrollView addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.bounds.size.width - 40, 1000 - 200)];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:22];
        label.text = @"TwitterCover is a parallax top view with real time blur effect to any UIScrollView, inspired by Twitter for iOS.\n\nCompletely created using UIKit framework.\n\nEasy to drop into your project.\n\nYou can add this feature to your own project, TwitterCover is easy-to-use.";
        label;
    })];
}

-(void)dealloc{
    [_scrollView removeFlurryCoverView] ;
}


@end
