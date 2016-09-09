//
//  ViewController.m
//  HideTextDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>{
    NSString *rememberText ;
}

@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation ViewController

-  (void)viewDidLoad{
    [super viewDidLoad] ;
    self.textFiled.delegate = self ;
    [self.textFiled addTarget:self action:@selector(textHaveChange) forControlEvents:UIControlEventAllEvents] ;
    
    rememberText = @"" ;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    rememberText = [rememberText stringByReplacingCharactersInRange:range withString:string];
    return YES;
}

- (void)textHaveChange{
    if (rememberText.length > 4){
        NSMutableString *returnText = [NSMutableString string];
        [returnText appendString:[rememberText substringToIndex:2]];
        for (NSInteger i=0; i<(rememberText.length-4); i++){
            [returnText appendString:@"*"];
        }
        [returnText appendString:[rememberText substringFromIndex:rememberText.length-2]];
        [self.textFiled setText:returnText];
    }
    else{
        [self.textFiled setText:rememberText];
    }
}


@end
