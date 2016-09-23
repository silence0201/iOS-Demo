//
//  JSCallOCViewController.h
//  JavaScriptCoreDemo
//
//  Created by 杨晴贺 on 23/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestJsExport <JSExport>

JSExportAs 
(calculateForJS , //  handleFactorialCalculateWithNumber 作为js方法的别名
 - (void)handleFactorialCalculateWithNumber:(NSString *)number
 ) ;

- (void)pushViewController:(NSString *)view title:(NSString *)title;

@end

@interface JSCallOCViewController : UIViewController<UIWebViewDelegate,TestJsExport>

@end
