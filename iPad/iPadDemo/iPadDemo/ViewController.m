//
//  ViewController.m
//  iPadDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIButton *rememberPwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginBtn;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)login:(id)sender {
    NSString *account = self.accountField.text ;
    NSString *password = self.passwordField.text ;
    
    [self.view endEditing:YES] ;
    
    if(account.length == 0 || password.length == 0){
        [self showTipWithMessage:@"账号或密码不能为空"] ;
        return ;
    }
    
    self.loginView.userInteractionEnabled = NO ;
    
    CGFloat duration = 2.0 ;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating] ;
        if ([account isEqualToString:@"123"] && [password isEqualToString:@"123"]) {
            self.view.window.rootViewController = [MainViewController new] ;
        }else{
            [self showTipWithMessage:@"账号或密码错误"] ;
        }
    });
    
     [self.activityIndicator startAnimating] ;
    self.loginView.userInteractionEnabled = YES ;
}

- (void)showTipWithMessage:(NSString *)message{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"错误提示"
                                                                   message: message
                                                            preferredStyle:UIAlertControllerStyleAlert] ;
    UIAlertAction *action= [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil] ;
    [alter addAction:action] ;
    [self presentViewController:alter animated:YES completion:nil] ;
    
    CAKeyframeAnimation *shakeAnima = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"] ;
    shakeAnima.values = @[@-10,@0,@10,@0] ;
    shakeAnima.repeatCount = 3 ;
    shakeAnima.duration = 0.1 ;
    [self.loginView.layer addAnimation:shakeAnima forKey:nil] ;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.accountField) {
        [self.passwordField becomeFirstResponder] ;
    }else{
        [self login:nil] ;
    }
    return YES ;
}

- (IBAction)rememberPassword:(UIButton *)sender {
    sender.selected = !sender.selected ;
    if (!sender.isSelected) {
        self.autoLoginBtn.selected = NO ;
    }
}

- (IBAction)autoLoagin:(UIButton *)sender {
    sender.selected = !sender.selected ;
    
    if(sender.isSelected){
        self.rememberPwdBtn.selected = YES ;
    }
}


@end
