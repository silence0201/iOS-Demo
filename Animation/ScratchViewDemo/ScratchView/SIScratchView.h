//
//  SIScratchView.h
//  ScratchViewDemo
//
//  Created by 杨晴贺 on 07/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SIScratchView ;

@protocol SIScratchViewDelegate <NSObject>

/// 打开图层后的代理方法
- (void)scratchViewDidOpen:(SIScratchView *)scratchView ;

@end

@interface SIScratchView : UIView

/// 路径的宽度
@property (nonatomic,assign) CGFloat pathWidth ;

/// 行以及列的路径数,如果设置为3总共会分成3*3个块
@property (nonatomic,assign) NSUInteger pathCount ;

/// 最大路径数,经过多少块自动消失
@property (nonatomic,assign) NSUInteger maxPathCount ;

/// 被覆盖的View
@property (nonatomic,strong) UIView *coveredView ;

/// 代理
@property (nonatomic,weak) id<SIScratchViewDelegate>scratchViewDelegate ;

@end
