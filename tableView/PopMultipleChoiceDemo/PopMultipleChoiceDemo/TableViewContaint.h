//
//  TableViewContaint.h
//  PopMultipleChoiceDemo
//
//  Created by 杨晴贺 on 8/31/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickConfireBlock)(NSString *confire,NSArray *backArray) ;
typedef void(^ClickCancelBlock)() ;

@interface TableViewContaint : UIView

/**
 *  确认按钮回调
 */
@property (nonatomic,copy) ClickConfireBlock clickConfireBlock ;

/**
 *  取消按钮回调
 */
@property (nonatomic,copy) ClickCancelBlock clickCancelBlock ;

/**
 *  选择的数组
 */
@property (nonatomic,strong) NSArray *selectArray ;

/**
 *  数据
 */
@property (nonatomic,strong) NSArray *dataArray ;

// 构造
- (instancetype)initWithData:(NSArray *)dataArray andConfireBlock:(ClickConfireBlock)confireBlock andCancelBlock:(ClickCancelBlock)concelBlock ;
@end
