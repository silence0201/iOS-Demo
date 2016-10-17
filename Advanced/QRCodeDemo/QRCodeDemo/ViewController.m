//
//  ViewController.m
//  QRCodeDemo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "CreateQRCodeViewController.h"
#import "ScanQRCodeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)createAction:(id)sender {
    CreateQRCodeViewController *create = [[CreateQRCodeViewController alloc]init] ;
    [self showViewController:create sender:self] ;
}
- (IBAction)scanAction:(id)sender {
    ScanQRCodeViewController *scan = [[ScanQRCodeViewController alloc]init] ;
    [self showViewController:scan sender:self] ;
}


@end
