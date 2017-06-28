//
//  CycleLoopScrollView.h
//  CycleLoopScrollViewDemo
//
//  Created by 杨晴贺 on 2017/6/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CycleLoopScrollView ;

@protocol CycleLoopScrollViewDelegate <NSObject>

@required
- (NSInteger)numberOfCountentViewInCycleLoopScrollView:(CycleLoopScrollView *)loopScrollView ;
- (UIView *)cycleLoopScrollView:(CycleLoopScrollView *)cycleLoopScrollView contentViewAtIndex:(NSInteger)index ;

@optional
- (void)cycleLoopScrollView:(CycleLoopScrollView *)cycleLoopScrollView currentContentViewAtIndex:(NSInteger)index ;
- (void)cycleLoopScrollView:(CycleLoopScrollView *)cycleLoopScrollView didSelectContentViewAtIndex:(NSInteger)index ;

@end

@interface CycleLoopScrollView : UIView

@property (nonatomic,assign) id<CycleLoopScrollViewDelegate> delegate ;

- (instancetype)initWithFrame:(CGRect)frame animationScrollDuration:(NSTimeInterval)duration ;
- (void)reloadData ;

@end
