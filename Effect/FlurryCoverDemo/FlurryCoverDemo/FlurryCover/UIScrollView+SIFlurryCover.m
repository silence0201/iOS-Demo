//
//  UIScrollView+SIFlurryCover.m
//  FlurryCoverDemo
//
//  Created by 杨晴贺 on 24/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UIScrollView+SIFlurryCover.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static const void *UIScrollViewFlurryCover = &UIScrollViewFlurryCover;

@implementation UIScrollView (SIFlurryCover)

- (void)setCoverView:(SIFlurryCover *)coverView{
    [self willChangeValueForKey:@"coverView"] ;
    objc_setAssociatedObject(self, &UIScrollViewFlurryCover, coverView, OBJC_ASSOCIATION_ASSIGN) ;
    [self didChangeValueForKey:@"coverView"] ;
}

- (SIFlurryCover *)coverView{
    return objc_getAssociatedObject(self, &UIScrollViewFlurryCover) ;
}

- (void)addFlurryCoverWithImage:(UIImage *)image{
    [self addFlurryCoverWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) Image:image] ;
}

- (void)addFlurryCoverWithFrame:(CGRect)frame Image:(UIImage *)image{
    SIFlurryCover *coverView = [[SIFlurryCover alloc]initWithFrame:frame] ;
    coverView.backgroundColor = [UIColor clearColor];
    coverView.image = image;
    coverView.scrollView = self;
    
    if([self isKindOfClass:NSClassFromString(@"UITableView")]){
        UITableView *tableView = (UITableView *)self ;
        tableView.tableHeaderView = coverView ;
    }else{
        [self addSubview:coverView];
    }
    self.coverView = coverView;
}

- (void)removeFlurryCoverView{
    [self.coverView removeFromSuperview] ;
    self.coverView = nil ;
}


@end
