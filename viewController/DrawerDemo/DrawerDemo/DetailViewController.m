//
//  DetailViewController.m
//  DrawerDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "DetailViewController.h"
#import "UIViewController+EnableDrawer.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情页" ;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image =[UIImage imageNamed:@"2"] ;
    
    [self.view addSubview:imageView] ;
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]]  ;
    visualView.frame = self.view.bounds ;
    [self.view addSubview:visualView] ;
    
    [self enableOpenLeftDrawer:YES] ;
    [self enableOpenRightDrawer:NO] ;
    
}

@end
