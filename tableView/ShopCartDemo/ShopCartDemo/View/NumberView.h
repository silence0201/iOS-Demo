//
//  NumberView.h
//  ShopCartDemo
//
//  Created by 杨晴贺 on 08/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NumberView ;
@protocol NumberViewDelegate <NSObject>

- (void)numberView:(NumberView *)numberView reductAction:(UIButton *)button ;
- (void)numberView:(NumberView *)numberView addAction:(UIButton *)button ;

@end

@interface NumberView : UIView

@property (nonatomic,copy) NSString *numberStr ;  // 数量
@property (nonatomic,weak) id<NumberViewDelegate> delegate ;  // 增加删除代理

@end
