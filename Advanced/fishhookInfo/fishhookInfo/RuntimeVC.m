//
//  RuntimeVC.m
//  fishhookInfo
//
//  Created by Silence on 2019/5/6.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "RuntimeVC.h"
#import <objc/runtime.h>

@interface RuntimeVC ()

@end

@implementation RuntimeVC

- (IBAction)log1Action:(id)sender {
    NSLog(@"->1<-");
}

- (IBAction)log2Action:(id)sender {
    NSLog(@"->2<-");
}

- (IBAction)log3Action:(id)sender {
    NSLog(@"->3<-");
}


- (IBAction)log1ActionHook:(id)sender {
    [self exchangeInstanceMethod:[self class] method1Sel:@selector(log1Action:) method2Sel:@selector(new_log1Action:)];
}

- (IBAction)log2ActionHook:(id)sender {
    
    Method new_method = class_getInstanceMethod([self class], @selector(new_log2Action:));
    IMP new_methodIMP = method_getImplementation(new_method);
    const char *typeEncoding = method_getTypeEncoding(new_method);
    class_replaceMethod([self class], @selector(log2Action:), new_methodIMP, typeEncoding);
}

IMP (*old_onMethod)(id self,SEL _cmd);
- (IBAction)log3ActionHook:(id)sender {
    //GET & SET
    Method onLog3Action = class_getInstanceMethod([self class], sel_registerName("log3Action:"));
    //1.保存原始的IMP
    old_onMethod = method_getImplementation(onLog3Action);
    //2.SET
    method_setImplementation(onLog3Action, (IMP)new_log3Action);
}


- (void)new_log1Action:(id)sender {
    NSLog(@"->1<-来不了了");
}

- (void)new_log2Action:(id)sender {
    NSLog(@"->2<-来不了了");
}

void new_log3Action(id self,SEL _cmd,id sender){
    NSLog(@"->3<-来不了了");
}


- (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
    Method originalMethod = class_getInstanceMethod(anClass, method1Sel);
    Method swizzledMethod = class_getInstanceMethod(anClass, method2Sel);
    
    BOOL didAddMethod =
    class_addMethod(anClass,
                    method1Sel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(anClass,
                            method2Sel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
