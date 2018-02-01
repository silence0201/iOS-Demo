//
//  SIBaseTableViewController.h
//  NEStDemo
//
//  Created by Silence on 2018/2/1.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SIBaseTableViewController;
@protocol SIBaseTableViewControllerDelegate <NSObject>
- (void)childVc:(SIBaseTableViewController *)childVc scrollViewDidScroll:(UIScrollView *)scroll;
@end

@interface SIBaseTableViewController : UITableViewController

// 改变VC中的scroll偏移量
- (void)setCurrentScrollContentOffsetY:(CGFloat)offsetY;


@end
