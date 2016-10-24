//
//  ViewController.m
//  AttributedStringDemo
//
//  Created by 杨晴贺 on 24/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self NSMutableAttributedString] ;
}

- (void)NSMutableAttributedString{
    /**
     改变某个字符串中部分字符的显示样式
     // NSFontAttributeName                设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
     // NSForegroundColorAttributeNam      设置字体颜色，取值为 UIColor对象，默认值为黑色
     // NSBackgroundColorAttributeName     设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
     // NSLigatureAttributeName            设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
     // NSKernAttributeName                设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
     // NSStrikethroughStyleAttributeName  设置删除线，取值为 NSNumber 对象（整数）
     // NSStrikethroughColorAttributeName  设置删除线颜色，取值为 UIColor 对象，默认值为黑色
     // NSUnderlineStyleAttributeName      设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
     // NSUnderlineColorAttributeName      设置下划线颜色，取值为 UIColor 对象，默认值为黑色
     // NSStrokeWidthAttributeName         设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
     // NSStrokeColorAttributeName         填充部分颜色，不是字体颜色，取值为 UIColor 对象
     // NSShadowAttributeName              设置阴影属性，取值为 NSShadow 对象
     // NSTextEffectAttributeName          设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
     // NSBaselineOffsetAttributeName      设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
     // NSObliquenessAttributeName         设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
     // NSExpansionAttributeName           设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
     // NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
     // NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
     // NSLinkAttributeName                设置链接属性，点击后调用浏览器打开指定URL地址
     // NSAttachmentAttributeName          设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
     // NSParagraphStyleAttributeName      设置文本段落排版格式，取值为 NSParagraphStyle 对象
     */
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"《坦克世界》南北大区将于北京时间2016年04月01日09:45开放新模式“进击月球”，届时请您进入游戏体验。"] ;
    
    // 开始设置
    [text beginEditing] ;
#pragma mark - 字体
    // 改变字体的大小
    //NSFontAttributeName:这个属性的值是一个UIFont对象。使用这个属性来更改字体的文本
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(1, 4)] ;
    // 字体设置
    [text addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Optima" size:35] range:NSMakeRange(37, 6)] ;
    // 字体颜色
    //NSForegroundColorAttributeName:这个属性的值是一个用户界面颜色对象。使用这个属性来指定文本中呈现的颜色。如果不指定该属性,文本默认呈现黑色。
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(37, 6)] ;
#pragma mark - 下划线
    // 下滑线
    [text addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlinePatternDash) range:NSMakeRange(16, 16)] ;
    // 下划线的颜色
    [text addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor] range:NSMakeRange(16, 16)] ;
#pragma mark - 删除线
    // 删除线
    // NSStrikethroughStyleAttributeName:描述文本中的下划线属性。默认是NSUnderlineStyleNone
    [text addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(1, 4)] ;
    // 删除线颜色
    [text addAttribute:NSStrikethroughColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(1, 4)] ;
#pragma mark - 背景色
    // 添加背景色
    [text addAttribute:NSBackgroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(1, 4)] ;
#pragma mark - 填充字/空心字
    // 填充字
    [text addAttribute:NSStrokeWidthAttributeName value:@(-1) range:NSMakeRange(16, 16)] ;
    // 空心字
    [text addAttribute:NSStrokeWidthAttributeName value:@(1) range:NSMakeRange(6, 4)] ;
    // 改变填充字/空心字颜色
    [text addAttribute:NSStrokeColorAttributeName value:[UIColor greenColor] range:NSMakeRange(6, 4)];
#pragma mark - 添加图片
    // 添加图片
    /**
     步骤如下：
     创建NSTextAttachment的对象，用来装在图片
     将NSTextAttachment对象的image属性设置为想要使用的图片
     设置NSTextAttachment对象bounds大小，也就是要显示的图片的大小
     用[NSAttributedString attributedStringWithAttachment:attch]方法，将图片添加到富文本上
     */
    
    // 添加图片
    NSTextAttachment *attch = [[NSTextAttachment alloc]init] ;
    // 图片
    attch.image = [UIImage imageNamed:@"tank"] ;
    // 设置图片的大小
    attch.bounds = CGRectMake(0, 0, 50, 50) ;
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch] ;
    
    // 添加
    [text appendAttributedString:string] ;
    
    // 结束编辑
    [text endEditing] ;
    
    self.label.attributedText = text ;
}

@end
