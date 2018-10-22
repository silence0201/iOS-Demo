//
//  MyFontViewController.m
//  Font
//
//  Created by Silence on 2018/10/22.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "MyFontViewController.h"

@interface MyFontViewController ()

@end

@implementation MyFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"样式";
    UILabel *lable = ({
        UILabel *label = [[UILabel alloc]initWithFrame:self.view.bounds];
        label.center = self.view.center;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"abc&123?ABC?字体!";
        label.font = [UIFont fontWithName:self.fontStr size:30];
        label;
    }) ;
    
    [self.view addSubview:lable];
}


@end
