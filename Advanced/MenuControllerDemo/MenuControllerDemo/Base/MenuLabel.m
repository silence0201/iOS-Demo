//
//  MenuLabel.m
//  MenuControllerDemo
//
//  Created by 杨晴贺 on 22/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MenuLabel.h"

@implementation MenuLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup] ;
    }
    return self ;
}

- (void)awakeFromNib{
    [super awakeFromNib] ;
    [self setup] ;
}

- (void)setup{
    self.userInteractionEnabled = YES ;
    UILongPressGestureRecognizer *pressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress) ];
    [self addGestureRecognizer:pressGesture] ;
}

- (void)longPress{
    // 设置成为第一响应者
    [self becomeFirstResponder] ;
    
    // 设置UIMenuController
    UIMenuController *menu = [UIMenuController sharedMenuController] ;
    
    // 自定义UIMenuItem
    UIMenuItem *item1 = [[UIMenuItem alloc]initWithTitle:@"剪切" action:@selector(myCut:)] ;
    UIMenuItem *item2 = [[UIMenuItem alloc]initWithTitle:@"粘贴" action:@selector(myPaste:)] ;
    
    menu.menuItems = @[item1,item2] ;
    
    // 当长按lable的时候,这个方法不会调用,menu就会出现一闪一闪不断显示,需要在此处进行判断
    if(menu.isMenuVisible)return ;
    
    // 设置显示的相关信息
    [menu setTargetRect:self.bounds inView:self] ;
    
    // 显示
    [menu setMenuVisible:YES animated:YES] ;
}

#pragma mark --- 对权限进行控制
- (BOOL)canBecomeFirstResponder{
    return YES ;
}

// 设置可以执行的操作
/**  系统默认方法：
 
 cut:
 copy:
 select:
 selectAll:
 paste:
 delete:
 _promptForReplace:
 _transliterateChinese:
 _showTextStyleOptions:
 _define:
 _addShortcut:
 _accessibilitySpeak:
 _accessibilitySpeakLanguageSelection:
 _accessibilityPauseSpeaking:
 _share:
 makeTextWritingDirectionRightToLeft:
 makeTextWritingDirectionLeftToRight:
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if(action == @selector(cut:)
       || action == @selector(copy:)
       || action == @selector(myCut:)
       || action == @selector(myPaste:)){
        return YES ;
    }
    return NO ;
}

- (void)myCut:(UIMenuController *)menu{
    NSLog(@"%s",__func__) ;
    // 复制文字到剪贴板
    [self copy:menu] ;
    // 清空文字
    self.text = nil ;
}

- (void)cut:(UIMenuController *)menu{
    NSLog(@"%s",__func__) ;
    // 复制文字到剪贴板
    [self copy:menu] ;
    // 清空文字
    self.text = nil ;
}

- (void)copy:(UIMenuController *)menu{
    // 当没有文字调用这个方法会崩溃
    if(!self.text) return ;
    // 复制文字到剪贴板
    UIPasteboard *paste = [UIPasteboard generalPasteboard] ;
    paste.string = self.text ;
    
}

- (void)myPaste:(UIMenuController *)menu{
    // 将剪贴板的文字赋值给Label
    UIPasteboard *paste = [UIPasteboard generalPasteboard] ;
    self.text = paste.string ;
}

@end
