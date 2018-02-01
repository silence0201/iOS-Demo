//
//  SISegmentBar.h
//  NEStDemo
//
//  Created by Silence on 2018/2/1.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SISegmentBar;
@protocol SISegmentBarDeleggate <NSObject>

- (void)segmentBar:(SISegmentBar *)segmentBar selectedIndex:(NSInteger)index;

@end

@interface SISegmentBar : UIView

@property (nonatomic,weak) id<SISegmentBarDeleggate> delegate;

@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,strong) NSArray <NSString *> *titles;

- (instancetype)initWithTitles:(NSArray <NSString *> *)titles ;

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
                 selectedColor:(UIColor *)selectedColor
                   normalColor:(UIColor *)normalColor;

@end
