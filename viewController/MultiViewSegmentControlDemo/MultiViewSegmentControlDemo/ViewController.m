//
//  ViewController.m
//  MultiViewSegmentControlDemo
//
//  Created by 杨晴贺 on 8/11/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (nonatomic,strong) FirstViewController *firstVC ;
@property (nonatomic,strong) SecondViewController *secondVC ;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstVC = [[FirstViewController alloc]initWithNibName:@"FirstViewController" bundle:nil] ;
    self.secondVC = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil] ;
    
    self.firstVC.view.frame = [UIScreen mainScreen].bounds ;
    self.secondVC.view.frame = [UIScreen mainScreen].bounds ;
    
    [self.view addSubview:self.firstVC.view] ;
    [self.view bringSubviewToFront:self.segmentControl] ;
    
    self.segmentControl.selectedSegmentIndex = 0 ;
}

- (IBAction)valueChange:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.secondVC removeFromParentViewController] ;
        [self.view addSubview:self.firstVC.view] ;
    }else{
        [self.firstVC removeFromParentViewController] ;
        [self.view addSubview:self.secondVC.view] ;
    }
    [self.view bringSubviewToFront:self.segmentControl] ;
}



@end
