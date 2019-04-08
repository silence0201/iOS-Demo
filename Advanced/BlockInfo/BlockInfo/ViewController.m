//
//  ViewController.m
//  BlockInfo
//
//  Created by Silence on 2019/4/1.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"

void test() {
    //下面分别定义各种类型的变量
    int a = 10;                       //普通变量
    __block int b = 20;                //带__block修饰符的block普通变量
    NSString *str = @"123";
    __block NSString *blockStr = str;  //带__block修饰符的block OC变量
    NSString *strongStr = @"456";      //默认是__strong修饰的OC变量
    __weak NSString *weakStr = @"789"; //带__weak修饰的OC变量
    //定义一个block块并带一个参数
    void (^testBlock)(int) = ^(int c){
        int  d = a + b + c;
        NSLog(@"d=%d, strongStr=%@, blockStr=%@, weakStr=%@", d, strongStr, blockStr, weakStr);
    };
    
    a = 20;  //修改值不会影响testBlock内的计算结果
    b = 40;  //修改值会影响testBlock内的计算结果。
    testBlock(30);  //执行block代码。
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    test();
}


@end
