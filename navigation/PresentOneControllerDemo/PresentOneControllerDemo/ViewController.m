//
//  ViewController.m
//  PresentOneControllerDemo
//
//  Created by 杨晴贺 on 04/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "InteractiveTransition.h"
#import "PresentViewController.h"


@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"弹性Present" ;
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = [UIImage imageNamed:@"2"] ;
    imageView.contentMode = UIViewContentModeScaleToFill ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    [self.view addSubview:imageView] ;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 300, 50)] ;
    button.titleLabel.textAlignment = NSTextAlignmentCenter ;
    [button setTitle:@"点击或上划弹出" forState:UIControlStateNormal] ;
    [self.view addSubview:button] ;
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view) ;
    }] ;
    
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    
    _interactivePush = [InteractiveTransition interactiveTransitionWithTransitionType:InteractiveTransitionTypePresent GestureDirection:InteractiveTransitionGestureDirectionUp];
    typeof(self)weakSelf = self;
    _interactivePush.presentConifg = ^(){
        [weakSelf present];
    };
    [_interactivePush addPanGestureForViewController:self.navigationController];

}

- (void)present{
    [self presentViewController:[PresentViewController new] animated:YES completion:nil] ;
}




@end
