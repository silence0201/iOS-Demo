//
//  ViewController.m
//  SelectCityDemo
//
//  Created by 杨晴贺 on 15/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "CitySelectView.h"

@interface ViewController (){
    UILabel *_cityLabel ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blueColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.frame = CGRectMake(50, 100, self.view.frame.size.width-100, 40);
    [btn setTitle:@"选择省市区" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn] ;
    
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)] ;
    _cityLabel.center = self.view.center ;
    _cityLabel.textAlignment = NSTextAlignmentCenter ;
    _cityLabel.text = @"省市区" ;
    [self.view addSubview:_cityLabel] ;
}


- (void)btnClick:(UIButton *)btn{
    NSLog(@"点一下");
    CitySelectView *selectView = [[CitySelectView alloc]initWithFrame:self.view.bounds withSelectCityTitle:@"请选择地区"] ;
    
    [selectView showCityView:^(NSString *proviceStr, NSString *cityStr, NSString *disStr) {
        _cityLabel.text = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,disStr];
    }];
}



@end
