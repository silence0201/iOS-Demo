//
//  ChildViewController.m
//  DisplayViewControllerDemo
//
//  Created by 杨晴贺 on 02/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ChildViewController.h"
#import "RequestCover.h"
#import "YZDisplayViewHeader.h"

@interface ChildViewController (){
    RequestCover *_cover ;
    UIImageView *_imageView ;
}

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData)
                                                 name:YZDisplayViewClickOrScrollDidFinshNote
                                               object:self];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    _imageView = imageView ;
    
    // 添加模板
    RequestCover *cover = [[RequestCover alloc]initWithFrame:self.view.frame] ;
    [self.view addSubview:cover] ;
    _cover = cover ;
}

- (void)loadData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@--请求数据成功",self.title) ;
        [_cover removeFromSuperview] ;
        _imageView.image = [UIImage imageNamed:self.imageName] ;
    });
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName ;
    _imageView.image = [UIImage imageNamed:imageName] ;
}




@end
