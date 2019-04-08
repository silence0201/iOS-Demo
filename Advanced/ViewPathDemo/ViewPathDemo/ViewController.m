//
//  ViewController.m
//  ViewPathDemo
//
//  Created by Silence on 2019/4/8.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ViewPath.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"label1:%@",_label1.viewPath);
    NSLog(@"label2:%@",_label2.viewPath);
    NSLog(@"label3:%@",_label3.viewPath);
    NSLog(@"label4:%@",_label4.viewPath);
}


@end
