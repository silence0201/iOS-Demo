//
//  JSCallOCViewController.m
//  JavaScriptCoreDemo
//
//  Created by 杨晴贺 on 23/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "JSCallOCViewController.h"

@interface JSCallOCViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) JSContext *context;

@end

@implementation JSCallOCViewController

#pragma mark - Life Cycle
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // init
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"JavaScript调用Objective-C" ;
    self.webView.delegate = self ;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"JSCallOC.html" ofType:nil] ;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]] ;
    [self.webView loadRequest:request] ;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // 以 html title 设置 导航栏 title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"] ;
    // Undocumented access to UIWebView's JSContext
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 打印异常
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception){
        context.exception = exception ;
        NSLog(@"%@",exception) ;
    } ;
    
    // 以 JSExport 协议关联native 的方法
    self.context[@"app"] = self ;
    
    // 以block形式关联 JavaScript function
    self.context[@"log"] = ^(NSString *str){
        NSLog(@"%@",str) ;
    } ;
    
    self.context[@"alert"] = ^(NSString *str){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"从JavaScript收到消息" message:str delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show] ;
    } ;
    
    __block typeof(self) weakSelf = self ;
    self.context[@"addSubView"] = ^(NSString *viewName){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 500, 100, 100)] ;
        view.backgroundColor = [UIColor redColor] ;
        [weakSelf.view addSubview:view] ;
    } ;
    
    // 多个参数
    self.context[@"mutiParams"] = ^(NSString *a,NSString*b,NSString *c){
        NSLog(@"%@ %@ %@",a,b,c) ;
    } ;
}

#pragma mark - JSExport Method
- (void)handleFactorialCalculateWithNumber:(NSString *)number{
    NSNumber *result  =  [self calculateFactorialOfNumber:@([number integerValue])];
    [self.context[@"showResult"] callWithArguments:@[result]] ;
}

- (void)pushViewController:(NSString *)view title:(NSString *)title{
    Class second = NSClassFromString(view);
    id secondVC = [[second alloc]init];
    ((UIViewController*)secondVC).title = title;
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark - Private Method
- (NSNumber *)calculateFactorialOfNumber:(NSNumber *)number{
    NSInteger i = [number integerValue];
    if (i < 0){
        return [NSNumber numberWithInteger:0];
    }
    if (i == 0){
        return [NSNumber numberWithInteger:1];
    }
    
    NSInteger r = (i * [(NSNumber *)[self calculateFactorialOfNumber:[NSNumber numberWithInteger:(i - 1)]] integerValue]);
    
    return [NSNumber numberWithInteger:r];
}

@end
