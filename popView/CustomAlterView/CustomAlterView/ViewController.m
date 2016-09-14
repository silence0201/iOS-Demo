//
//  ViewController.m
//  CustomAlterView
//
//  Created by 杨晴贺 on 9/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlterView.h"
#import "MBProgressHUD+YS.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<CustomAlterButtonDelegate>

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    imageView.image = [UIImage imageNamed:@"bg"] ;
    [self.view addSubview:imageView] ;
    
    // 添加启动按钮
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame=CGRectMake(0, 20, 40, 44);
    [addBtn setImage:[UIImage imageNamed:@"add_SelectStore"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtnItem=[[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    // 导航栏透明
    UIImage *image = [[UIImage alloc]init] ;
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault] ;
    [self.navigationController.navigationBar setShadowImage:image] ;
}

#pragma mark - Action
- (void)addBtnClicked:(id)sender{
    CGFloat alertH=250;
    CustomAlterView *alertView = [[CustomAlterView alloc] initWithFrame:CGRectMake(50, ((SCREEN_HEIGHT-alertH)*0.3), SCREEN_WIDTH-100, alertH)];
    alertView.buttonDelegate=self;
    [alertView show];
    
}

#pragma mark - CustomAlterButtonDelegate
-(void)saveClickButton :(UIButton*)saveBtn{
    UITextField *name = [saveBtn.superview viewWithTag:100];
    UITextField *password=[saveBtn.superview viewWithTag:101];
    if(name.text.length && password.text.length ){
        NSLog(@"获取的名称：%@", name.text);
        NSLog(@"获取的密码: %@",password.text);
        [MBProgressHUD showSuccess:@"保存成功!"];
    }else{
        [MBProgressHUD showError:@"不能为空!"];
    }
}

@end
