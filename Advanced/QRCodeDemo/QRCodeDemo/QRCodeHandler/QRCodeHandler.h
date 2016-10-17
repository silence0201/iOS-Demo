//
//  QRCodeHandler.h
//  QRCodeDemo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^RecoginzedCompleteBlock)(NSString *messageString,BOOL success);

@protocol SIRecognizeQRCodeDelegate <NSObject>

- (void)qrCodeMessageString:(NSString *)messageString;

@end

@interface QRCodeHandler : NSObject


#pragma mark - 生成二维码
/**
 生成二维码

 @param messageString 二维码信息字符串

 @return 返回的二维码
 */
+ (UIImage *)createQRCodeForString:(NSString *)messageString withImageViewSize:(CGSize)size ;

#pragma mark - 扫描二维码
- (instancetype)initInView:(UIView *)superView withCaptureFrame:(CGRect)frame;
@property (nonatomic,weak) id<SIRecognizeQRCodeDelegate> delegate ;
// 扫描识别之后会自动关闭,继续扫描重新打开
- (void)startRunning ;
- (void)stopRunning ;

#pragma mark - 识别二维码
+ (NSString *)recognizedQRCodeOfImage:(UIImage *)image complete:(RecoginzedCompleteBlock)completeBlock ;
@end
