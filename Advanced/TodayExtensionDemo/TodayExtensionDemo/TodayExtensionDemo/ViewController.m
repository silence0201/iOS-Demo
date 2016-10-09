//
//  ViewController.m
//  TodayExtensionDemo
//
//  Created by 杨晴贺 on 09/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFiled;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)setAction:(id)sender {
    NSUserDefaults *sharedDefault = [[NSUserDefaults alloc]initWithSuiteName:@"group.silence.TodayDefault"] ;
    [sharedDefault setInteger:[self.textFiled.text integerValue] forKey:@"numberKey"] ;
    [sharedDefault synchronize] ;
}

@end
