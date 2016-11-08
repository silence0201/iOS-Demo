//
//  ShopModel.h
//  ShopCartDemo
//
//  Created by 杨晴贺 on 08/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject

@property (nonatomic,copy) NSString *imageName ;   // 商品的图片名称
@property (nonatomic,copy) NSString *goodTitle ;   // 商品的标题
@property (nonatomic,copy) NSString *goodType ;   // 商品的类型
@property (nonatomic,copy) NSString *goodPrice ;   // 商品的价格
@property (nonatomic,copy) NSString *oldGoodPrice ;  // 商品原价格
@property (nonatomic,assign) BOOL selectState ;  // 是否选中状态
@property (nonatomic,assign) NSInteger goodCount ;  // 商品的个数

- (instancetype)initWithShopDic:(NSDictionary *)dic ;
+ (instancetype)shopWithDic:(NSDictionary *)dic ;

@end
