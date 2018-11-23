//
//  ViewController.m
//  FishHookDemo
//
//  Created by Silence on 2018/11/23.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "fishhook.h"

static void (*orig_NSLog)(NSString *format, ...);

void new_NSLog(NSString *format, ...) {
    format = [NSString stringWithFormat:@"%@-- Hook By Silence",format];
    orig_NSLog(format);
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    struct rebinding rebfunc;
    rebfunc.name = "NSLog";
    rebfunc.replacement = new_NSLog;
    rebfunc.replaced = (void *)&orig_NSLog;
    
    struct rebinding rebfuncs[1] = {rebfunc};
    rebind_symbols(rebfuncs, 1);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Hello,World");
}


@end
