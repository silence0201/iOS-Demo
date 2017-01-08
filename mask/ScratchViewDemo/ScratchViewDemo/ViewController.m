//
//  ViewController.m
//  ScratchViewDemo
//
//  Created by 杨晴贺 on 07/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "ViewController.h"
#import "SIScratchView.h"


@interface ViewController ()

@property (nonatomic,strong) SIScratchView *scratchView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(75,100, 150, 250) ];
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    imageView.image = [UIImage imageNamed:@"1"] ;
    imageView.clipsToBounds = YES ;
    [self.view addSubview:imageView] ;
    
    //自定义覆盖view
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 250)];
    coverView.backgroundColor = [UIColor greenColor];
    
    //添加
    [self.scratchView setCoveredView:coverView];
    [self.view addSubview:self.scratchView];
}

- (SIScratchView *)scratchView {
    if (_scratchView == nil) {
        _scratchView = [[SIScratchView alloc] initWithFrame:CGRectMake(75, 100, 150, 250)];
        _scratchView.maxPathCount = 30;
        _scratchView.pathWidth = 50.0;
        _scratchView.pathCount = 6 ;
    }
    
    return _scratchView;
}

@end
