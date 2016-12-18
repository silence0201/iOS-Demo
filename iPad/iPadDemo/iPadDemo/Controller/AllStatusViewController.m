//
//  AllStatusViewController.m
//  iPadDemo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AllStatusViewController.h"

@interface AllStatusViewController ()

@property (nonatomic,strong) UIImageView *imageView ;

@end

@implementation AllStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = [UIImage imageNamed:@"0"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    _imageView = imageView ;
    [self.view addSubview:imageView] ;
    
    NSArray *items = @[@"全部", @"特别关心", @"好友动态", @"认证空间"];
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:items];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [sc setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [sc setTintColor:[UIColor lightGrayColor]];
    sc.selectedSegmentIndex = 0;
    self.navigationItem.titleView = sc ;
    [sc addTarget:self action:@selector(scClick:) forControlEvents:UIControlEventValueChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil] ;
}

- (void)scClick:(UISegmentedControl *)sc{
    NSLog(@"%ld", sc.selectedSegmentIndex);
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",sc.selectedSegmentIndex]] ;
}

- (void)orientationDidChange:(NSNotification *)noti{
    self.imageView.size = self.view.size ;
}

@end
