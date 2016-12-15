//
//  ImageDisplayExample.m
//  YYImageDemo
//
//  Created by 杨晴贺 on 15/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ImageDisplayExample.h"
#import "UIView+YYAdd.h"
#import <YYWebImage/YYWebImage.h>

@interface ImageDisplayExample ()

@property (nonatomic,strong) UIScrollView *scrollView ;

@end

@implementation ImageDisplayExample

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.863 alpha:1.000] ;
    
    [self.view addSubview:self.scrollView] ;
    
    [self addImageWithName:@"niconiconi" text:@"Animated GIF"] ;
    [self addImageWithName:@"pia" text:@"Animated PNG (APNG)"] ;
    
    [self addFrameImageWithText:@"Frame Animation"] ;
    [self addSpriteSheetImageWithText:@"Sprite Sheet Animation"] ;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init] ;
        _scrollView.frame = self.view.bounds ;
        
    }
    return _scrollView ;
}

- (void)addImageWithName:(NSString *)name text:(NSString *)text{
    YYImage *image = [YYImage imageNamed:name] ;
    [self addImage:image size:CGSizeZero text:text] ;
}

- (void)addImage:(UIImage *)image size:(CGSize)size text:(NSString *)text{
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc]initWithImage:image] ;
    if (size.width > 0 && size.height > 0) imageView.size = size;
    imageView.centerX = self.view.width / 2 ;
    imageView.top = [[_scrollView.subviews lastObject] bottom] + 30 ;
    [_scrollView addSubview:imageView] ;
    
    UILabel *imageLabel = [[UILabel alloc]init] ;
    imageLabel.backgroundColor = [UIColor clearColor] ;
    imageLabel.frame = CGRectMake(0, 0, self.view.width, 20);
    imageLabel.top = imageView.bottom + 10;
    imageLabel.textAlignment = NSTextAlignmentCenter;
    imageLabel.text = text;
    [_scrollView addSubview:imageLabel];
    
    _scrollView.contentSize = CGSizeMake(self.view.width, imageLabel.bottom + 20) ;
}

- (void)addFrameImageWithText:(NSString *)text{
    NSString *basePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"EmoticonWeibo.bundle/com.sina.default"];
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_aini@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_baibai@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_chanzui@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_chijing@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_dahaqi@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_guzhang@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_haha@2x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_haixiu@3x.png"]];
    UIImage *image = [[YYFrameImage alloc] initWithImagePaths:paths oneFrameDuration:0.1 loopCount:0];
    [self addImage:image size:CGSizeZero text:text] ;
}

- (void)addSpriteSheetImageWithText:(NSString *)text{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fav02c-sheet" ofType:@"png"] ;
    UIImage *sheet = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:path] scale:2];
    
    NSMutableArray *contentRects = [NSMutableArray new];
    NSMutableArray *durations = [NSMutableArray new];
    
    CGSize size = CGSizeMake(sheet.size.width / 8, sheet.size.height / 12);
    for (int j = 0; j < 12; j++) {
        for (int i = 0; i < 8; i++) {
            CGRect rect;
            rect.size = size;
            rect.origin.x = sheet.size.width / 8 * i;
            rect.origin.y = sheet.size.height / 12 * j;
            [contentRects addObject:[NSValue valueWithCGRect:rect]];
            [durations addObject:@(1 / 60.0)];
        }
    }
    YYSpriteSheetImage *sprite;
    sprite = [[YYSpriteSheetImage alloc] initWithSpriteSheetImage:sheet
                                                     contentRects:contentRects
                                                   frameDurations:durations
                                                        loopCount:0];
    
    [self addImage:sprite size:size text:text] ;
}

@end
