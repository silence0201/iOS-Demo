//
//  ScanQRCodeViewController.m
//  QRCodeDemo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "UIView+Frame.h"
#import "QRCodeHandler.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height

@interface ScanQRCodeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,SIRecognizeQRCodeDelegate>

@property (nonatomic,strong) QRCodeHandler *qrCodeHandler ;

@end

@implementation ScanQRCodeViewController{
    UIImagePickerController *_imagePicker ;
}

#pragma mark - Cycle Life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描二维码" ;
    [self setupUI] ;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    [self.qrCodeHandler startRunning] ;
}

#pragma mark - 界面初始化
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(selectForPhotoLibraryAction:)] ;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, DeviceWidth-20, DeviceWidth-20)] ;
    imageView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:imageView] ;
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(15, imageView.bottom+10, self.view.width-30, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.font = [UIFont systemFontOfSize:14];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.text=@"将二维码/条形码放入框内，即可自动扫描";
    [self.view addSubview:labIntroudction];
    
    UIButton * retry = [UIButton buttonWithType:UIButtonTypeCustom];
    retry.frame = CGRectMake(30, labIntroudction.bottom+10, DeviceWidth-30*2, 40);
    [retry setTitle:@"重新扫描" forState:0<<6];
    retry.backgroundColor = [UIColor orangeColor];
    [retry addTarget:self action:@selector(retry:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:retry];
    
    
    self.qrCodeHandler = [[QRCodeHandler alloc] initInView:self.view withCaptureFrame:CGRectMake(20, 90, DeviceWidth-40, DeviceWidth-40)];
    self.qrCodeHandler.delegate = self;
    
}

- (void)setupImagePickerController{
    _imagePicker = [[UIImagePickerController alloc]init] ;
    _imagePicker.allowsEditing = NO ;
    _imagePicker.delegate = self ;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
    
    // 系统相册
    [self presentViewController:_imagePicker animated:YES completion:nil] ;
}




#pragma mark - Action
- (void)selectForPhotoLibraryAction:(UIBarButtonItem *)barButton{
    [self setupImagePickerController] ;
}

- (void)retry:(UIButton *)button{
    [self.qrCodeHandler startRunning] ;
}

#pragma mark - 扫描二维码的回调
- (void)qrCodeMessageString:(NSString *)messageString{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"内容" message:messageString delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - 识别图中的二维码
- (void)recognizedQRCodeOfImage:(UIImage *)image{
    [QRCodeHandler recognizedQRCodeOfImage:image complete:^(NSString *messageString, BOOL success) {
        if(success){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"内容" message:messageString delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"识别失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }] ;
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    _imagePicker = nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType] ;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        [picker dismissViewControllerAnimated:YES completion:nil] ;
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage] ;
        [self recognizedQRCodeOfImage:image] ;
    }
    _imagePicker = nil ;
}
@end
