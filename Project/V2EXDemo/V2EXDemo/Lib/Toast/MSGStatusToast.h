//
//  MSGStatusToast.h
//  MSGStatus
//
//  Created by iurw on 15/9/3.
//  Copyright (c) 2015年 iurw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSGStatusToast : UIView

/** 单例对象 */
+ (MSGStatusToast *)shareMSGToast;

/** 显示消息 */
- (void)showMsg:(NSString *)message autoHide:(BOOL)hide;

/** 成功消息 */
- (void)showFinish:(NSString *)message autoHide:(BOOL)hide;

/** 加载错误 */
- (void)showError:(NSString *)message autoHide:(BOOL)hide;

/** 加载中 */
- (void)showLoadAutoHide:(BOOL)hide;

/** 隐藏 */
- (void)hide;

@end
