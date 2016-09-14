//
//  CustomAlterView.m
//  CustomAlterView
//
//  Created by 杨晴贺 on 9/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CustomAlterView.h"
#import "UIView+Frame.h"



#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define COLOR [UIColor colorWithRed:255.0/255.0 green:95.0/255.0 blue:0.0/255.0 alpha:1.0]

@interface CustomAlterView ()

@property (nonatomic,strong) UIView *backgroudView ;
@property (nonatomic,strong) UIView *alterBackgroudView ;

@end

@implementation CustomAlterView

#pragma mark - 子控件初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5 ;
        self.backgroundColor = [UIColor clearColor] ;
        self.clipsToBounds = YES ;
        
        self.alterBackgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)] ;
        [self addSubview:self.alterBackgroudView] ;
        
        // 头部背景图片
        UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.width, 55)] ;
        titleView.userInteractionEnabled = YES ;
        titleView.image = [UIImage imageNamed:@"notice_title"] ;
        [self.alterBackgroudView addSubview:titleView] ;
        
        // 取消按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(self.alterBackgroudView.width-43,-6,50, 50);
        [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setImage:[UIImage imageNamed:@"notice_close"]forState:UIControlStateNormal];
        [ self.alterBackgroudView addSubview:cancelBtn];
        
        // 表单输入模块
        UIView *containView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), self.width, self.height-50)] ;
        containView.backgroundColor = [UIColor whiteColor] ;
        [self addSubview:containView] ;
        
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(35, 25, 50, 25)];
        nameLabel.text = @"用户名" ;
        nameLabel.textAlignment = NSTextAlignmentCenter ;
        nameLabel.font = [UIFont systemFontOfSize:15] ;
        [containView addSubview:nameLabel] ;
        
        UITextField *nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame)+3, 25, 140, 25)] ;
        nameTextField.tag = 100 ;
        nameTextField.layer.borderWidth = 1 ;
        nameTextField.layer.borderColor = [UIColor blackColor].CGColor ;
        nameTextField.layer.cornerRadius = 5 ;
        nameTextField.secureTextEntry = NO ;
        [containView addSubview:nameTextField] ;
        
        UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(35,CGRectGetMaxY(nameLabel.frame)+25 , 50, 25)] ;
        passwordLabel.text = @"密码" ;
        passwordLabel.textAlignment = NSTextAlignmentCenter ;
        passwordLabel.font = [UIFont systemFontOfSize:15] ;
        [containView addSubview:passwordLabel] ;
        
        UITextField *passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(passwordLabel.frame)+3, CGRectGetMaxY(nameTextField.frame)+24, 140, 25)] ;
        passwordTextField.tag = 101 ;
        passwordTextField.layer.borderWidth = 1 ;
        passwordTextField.layer.borderColor = [UIColor blackColor].CGColor ;
        passwordTextField.layer.cornerRadius = 5 ;
        passwordTextField.secureTextEntry = YES ;
        [containView addSubview:passwordTextField] ;
        
        // 确认按钮
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake((self.width-90)*0.5,CGRectGetMaxY(passwordTextField.frame)+38,90, 27);
        [confirmBtn setBackgroundColor:COLOR];
        confirmBtn.layer.cornerRadius = 5;
        [confirmBtn addTarget:self action:@selector(saveClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [containView addSubview:confirmBtn];
        
        [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification  object:nil];
        
    }
    return self ;
}

#pragma mark - Action
// 取消按钮
- (void)cancelClick:(UIButton *)cancelBtn{
    [self close] ;
}
// 点击时间
- (void)tap:(UITapGestureRecognizer *)tap{
    [self close];
}
// 确认按钮
- (void)saveClickButton:(UIButton *)saveBtn{
    if([self.buttonDelegate respondsToSelector:@selector(saveClickButton:)]){
        [self.buttonDelegate saveClickButton:saveBtn] ;
    }
    [self close] ;
}

// 键盘改变通知
- (void)keyboardWillChange:(NSNotification  *)notification{
    // 获取键盘的Y值
    NSDictionary *dic = notification.userInfo ;
    CGRect keyboardFrame = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y ;
    // 获取东湖执行时间
    CGFloat duration = [dic[UIKeyboardAnimationDurationUserInfoKey] doubleValue] ;
    // 计算需要移动的距离
    CGFloat selfY = keyboardY - self.height - 50 ;
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        // 需要执行动画的代码
        self.y = selfY;
        self.backgroudView.alpha = 0.5;
    } completion:^(BOOL finished) {
        // 动画执行完毕执行的代码
        if (_backgroudView == nil) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Private Method
- (void)close{
    [self.backgroudView removeFromSuperview] ;
    self.backgroudView = nil ;
    [self removeFromSuperview] ;
}

- (void)dealloc{
    // 注销通知
    [[NSNotificationCenter defaultCenter]removeObserver:self] ;
}

#pragma mark - Public Method
- (void)show{
    if(self.backgroudView){
        return ;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow ;
    self.backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)] ;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)] ;
    [self.backgroudView addGestureRecognizer:tap] ;
    self.backgroudView.backgroundColor = [UIColor blackColor] ;
    self.backgroudView.alpha = 0.3 ;
    // 遮罩背景层
    [window addSubview:self.backgroudView] ;
    // 显示内容
    [window addSubview:self] ;
}



@end
