//
//  ShopCartCell.h
//  ShopCartDemo
//
//  Created by 杨晴贺 on 08/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height //主屏幕的高度
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width  //主屏幕的宽度

@class ShopCartCell ;
@protocol ShopCartCellDelegate <NSObject>

- (void)btnClick:(UITableViewCell *)cell addFlag:(NSInteger)flag ;

@end

@interface ShopCartCell : UITableViewCell

@property (nonatomic,strong) ShopModel *shopModel ;    // 购物车模型
@property (nonatomic,weak) id<ShopCartCellDelegate> delegate ;  // 处理代理

@end
