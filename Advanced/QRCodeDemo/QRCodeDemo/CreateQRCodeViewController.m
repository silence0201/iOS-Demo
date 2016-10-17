//
//  CreateQRCodeViewController.m
//  QRCodeDemo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CreateQRCodeViewController.h"
#import "UIView+Frame.h"
#import "QRCodeHandler.h"

#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height

@interface CreateQRCodeViewController ()

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UIImageView * QRCodeImageView;
@property (nonatomic, strong) UIButton * saveBtn;

@end

@implementation CreateQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产生二维码" ;
    [self setupUI] ;
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addTarget:self action:@selector(tap:)];
    
    CGFloat textFieldLeft = 20;
    CGFloat textFieldTop = 80;
    CGFloat textFieldHeight = 30;
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldLeft, textFieldTop, DeviceWidth-textFieldLeft*2, textFieldHeight)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_textField];
    
    CGFloat btnLeft = 30;
    CGFloat btnTop = _textField.bottom+20;
    CGFloat btnHeight = 30;
    UIButton * creatbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    creatbtn.frame = CGRectMake(btnLeft, btnTop, DeviceWidth-btnLeft*2, btnHeight);
    [creatbtn setTitle:@"生成" forState:0<<6];
    creatbtn.backgroundColor = [UIColor orangeColor];
    [creatbtn addTarget:self action:@selector(creatAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatbtn];
    
    CGFloat imageViewLeft = 50;
    CGFloat imageViewTop = creatbtn.bottom+20;
    CGFloat imageViewSide = DeviceWidth-2*imageViewLeft;
    _QRCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewLeft, imageViewTop, imageViewSide, imageViewSide)];
    _QRCodeImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_QRCodeImageView];
    
    CGFloat saveBtnLeft = 30;
    CGFloat saveBtnTop = _QRCodeImageView.bottom+20;
    CGFloat saveBtnHeight = 30;
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.frame = CGRectMake(saveBtnLeft, saveBtnTop, DeviceWidth-saveBtnLeft*2, saveBtnHeight);
    [_saveBtn setTitle:@"保存到相册" forState:0<<6];
    _saveBtn.backgroundColor = [UIColor orangeColor];
    [_saveBtn addTarget:self action:@selector(saveQRCode:) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.enabled = NO;
    [self.view addSubview:_saveBtn];
}

- (void)tap:(UITapGestureRecognizer *)gesture{
    [self.view endEditing:YES] ;
}

- (void)creatAction:(UIButton *)button{
    if([_textField.text isEqualToString:@""] || !_textField.text.length){
        _saveBtn.enabled = NO ;
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:@"内容不能为空" preferredStyle:UIAlertControllerStyleAlert] ;
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alter addAction:cancelAction];
        [self presentViewController:alter animated:YES completion:nil];
        return ;
    }
    
    _QRCodeImageView.image = [QRCodeHandler createQRCodeForString:_textField.text withImageViewSize:_QRCodeImageView.bounds.size] ;
    _saveBtn.enabled = YES ;
    
}

- (void)saveQRCode:(UIButton *)button{
    UIImageWriteToSavedPhotosAlbum(_QRCodeImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil) ;
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"保存成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
