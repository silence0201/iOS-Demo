//
//  ThirdViewController.m
//  childViewControllerDemo
//
//  Created by 杨晴贺 on 8/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ThirdViewController.h"
#define debugMethod() NSLog(@"%s", __func__)
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    debugMethod();
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    debugMethod();
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    debugMethod();
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    debugMethod();
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    debugMethod();
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    debugMethod();
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    debugMethod();
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    debugMethod();
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
