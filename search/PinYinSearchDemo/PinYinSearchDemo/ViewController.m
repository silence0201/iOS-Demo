//
//  ViewController.m
//  PinYinSearchDemo
//
//  Created by 杨晴贺 on 9/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"
#import "AnotherViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)search:(UIButton *)sender {
    SearchViewController *searchViewController = [[SearchViewController alloc]init] ;
    [self.navigationController pushViewController:searchViewController animated:YES] ;
}

- (IBAction)anotherSearch:(UIButton *)sender {
    AnotherViewController *anotherViewController = [[AnotherViewController alloc]init] ;
    [self.navigationController pushViewController:anotherViewController animated:YES] ;
}



@end
