//
//  ViewController.m
//  versionUpdate
//
//  Created by 杨晴贺 on 25/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "VersionUpdateFunction.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)update:(id)sender {
    [VersionUpdateFunction versionUpdate] ;
}


@end
