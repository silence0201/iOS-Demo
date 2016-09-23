//
//  OCCallJSViewController.m
//  JavaScriptCoreDemo
//
//  Created by 杨晴贺 on 23/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "OCCallJSViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface OCCallJSViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputText;

@property (nonatomic,strong) JSContext *context ;

@end

@implementation OCCallJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Objective-C调用JavaScript" ;
    self.context = [[JSContext alloc]init] ;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"js"] ;
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] ;
    [self.context evaluateScript:jsScript] ;
}


- (IBAction)clickAction:(id)sender {
    NSNumber *inputNumber = [NSNumber numberWithInteger:[self.inputText.text integerValue]] ;
    JSValue *function = [self.context objectForKeyedSubscript:@"factorial"] ;
    JSValue *result = [function callWithArguments:@[inputNumber]] ;
    self.resultLabel.text = [NSString stringWithFormat:@"%@",[result toNumber]] ;
}

@end
