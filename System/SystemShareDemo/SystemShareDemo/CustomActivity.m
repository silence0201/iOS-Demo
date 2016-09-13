//
//  CustomActivity.m
//  SystemShareDemo
//
//  Created by 杨晴贺 on 9/13/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CustomActivity.h"

NSString *const UIActivityTypeCustomMine = @"CustomActivityMine" ;
@implementation CustomActivity

// 标识自定义服务的字符串
- (NSString *)activityType{
    return UIActivityTypeCustomMine ;
}

// 在视图中展示的服务的名称
- (NSString *)activityTitle{
    return @"自定义" ;
}

// 展示的服务图标
- (UIImage *)activityImage{
    return [UIImage imageNamed:@"guest"] ;
}

// UIActivityCategoryAction表示在最下面一栏的操作型服务,比如Copy、Print;UIActivityCategoryShare表示在中间一栏的分享型服务，比如一些社交软件。
+ (UIActivityCategory)activityCategory{
    return UIActivityCategoryShare ;
}

// 指定可以处理的数据类型，如果可以处理则返回YES
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
    NSLog(@"activityItems =%@",activityItems) ;
    return YES ;
}

// 在用户选择展示在UIActivityViewController中的自定义服务的图标之后，调用自定义服务处理方法之前的准备工作，都需要在这个方法中指定，比如可以根据数据展示一个界面来获取用户指定的额外数据信息
- (void)prepareWithActivityItems:(NSArray *)activityItems{
    NSLog(@"%s",__func__) ;
}

// 在用户选择展示在UIActivityViewController中的自定义服务的图标之后，而且也调用了prepareWithActivityItems:,就会调用这个方法执行具体的服务操作
- (void)performActivity{
    NSLog(@"%s",__func__);
}
// 调用结束后,执行
- (void)activityDidFinish:(BOOL)completed{
    NSLog(@"Activity finish");
}

@end
