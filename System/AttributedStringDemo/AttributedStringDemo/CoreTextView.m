//
//  CoreTextView.m
//  AttributedStringDemo
//
//  Created by 杨晴贺 on 24/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CoreTextView.h"
#import <CoreText/CoreText.h>

IB_DESIGNABLE
@implementation CoreTextView

-(void)drawRect:(CGRect)rect{
    /**
     CoreText 框架中最常用的几个类：
     有兴趣的请查阅资料
     
     CTFont
     CTFontCollection
     CTFontDescriptor
     CTFrame
     CTFramesetter
     CTGlyphInfo
     CTLine
     CTParagraphStyle
     CTRun
     CTTextTab
     CTTypesetter
     
     //kCTFontAttributeName 这个键是字体的名称 必须传入CTFont对象
     //kCTKernAttributeName 这个键设置字体间距 传入必须是数字对象 默认为0
     //kCTLigatureAttributeName  这个键设置连字方式 必须传入CFNumber对象
     //kCTParagraphStyleAttributeName  段落对其方式
     //kCTForegroundColorAttributeName 字体颜色 必须传入CGColor对象
     //kCTStrokeWidthAttributeName 笔画宽度 必须是CFNumber对象
     //kCTStrokeColorAttributeName 笔画颜色
     //kCTSuperscriptAttributeName 控制垂直文本定位 CFNumber对象
     //kCTUnderlineColorAttributeName 下划线颜色
     */
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"《坦克世界》南北大区将于北京时间2016年04月01日09:45开放新模式“进击月球”，届时请您进入游戏体验。"];
    
    // 开始设置
    [text beginEditing] ;
#pragma mark - 字体
    // 设置字体属性
    // 参数1.字体的名字 参数2.字体的大小 参数3.字体的变换矩阵。在大多数情况下,将该参数设置为NULL。
    CTFontRef font = CTFontCreateWithName(CFSTR("Optima-Regular"), 25, NULL);
    [text addAttribute:(id)kCTFontAttributeName value:(__bridge id _Nonnull)(font) range:NSMakeRange(0, text.length)];
    
    // 设置字体间距
    long number = 10 ;
    // 参数1.allocator:通过NULL或kCFAllocatorDefault使用默认的分配器。
    // 参数2.theType:通过CFNumber用来显示一个值的数据类型
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number) ;
    
    // kCTKernAttributeName:字距调整
    [text addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(37, 6)];
    
    // 设置字体的颜色
    // kCTForegroundColorAttributeName:文本的前景颜色。该属性的值必须是一个CGColor对象。默认值是黑色
    [text addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor purpleColor].CGColor range:NSMakeRange(0, text.length)];
    
    //设置空心字
    long number2 = 3;
    CFNumberRef num2 = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number2);
    [text addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id) num2 range:NSMakeRange(0, text.length)];
    
    //设置空心字颜色
    [text addAttribute:(id)kCTStrokeColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(16, 16)];
    
    //设置斜体字
    CTFontRef font2 = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:25].fontName, 25, NULL);
    [text addAttribute:(id)kCTFontAttributeName value:(__bridge id _Nonnull)(font2) range:NSMakeRange(16, 16)];
#pragma mark - 下划线
    //下划线
    [text addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] range:NSMakeRange(16, 16)];
    //下划线颜色
    [text addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor greenColor].CGColor range:NSMakeRange(16, 16)];

#pragma mark - 多属性设置
    //对同一段字体进行多属性设置
    //黑色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(id)[UIColor blackColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
    //斜体
    CTFontRef font3 = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 40, NULL);
    [attributes setObject:(__bridge id)font3 forKey:(id)kCTFontAttributeName];
    //下划线
    [attributes setObject:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] forKey:(id)kCTUnderlineStyleAttributeName];
    
    [text addAttributes:attributes range:NSMakeRange(1, 4)];
    
    //结束编辑
    [text endEditing];
    
#pragma mark - 渲染
    //绘图,渲染
    //设置绘制文字区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL ,self.bounds);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)text);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, text.length), path, NULL);
    //获取当前(View)上下文以用于之后的绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Flip the coordinate system
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    //x，y轴方向移动
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    //绘制
    CTFrameDraw(frame,context);
    
    //清理资源
    CGPathRelease(path);
    CFRelease(framesetter);
}

@end
