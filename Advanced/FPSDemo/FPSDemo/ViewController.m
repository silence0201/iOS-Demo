//
//  ViewController.m
//  FPSDemo
//
//  Created by 杨晴贺 on 15/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "FPSLabel.h"

@interface ViewController ()

@property (nonatomic,strong) FPSLabel *fpsLabel ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.fpsLabel] ;
    self.fpsLabel.center = self.view.center ;
}

- (FPSLabel *)fpsLabel{
    if (!_fpsLabel) {
        _fpsLabel = [[FPSLabel alloc]init] ;
    }
    return _fpsLabel ;
}



@end
