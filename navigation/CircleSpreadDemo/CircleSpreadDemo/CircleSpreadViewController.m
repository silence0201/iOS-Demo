//
//  CircleSpreadViewController.m
//  CircleSpreadDemo
//
//  Created by 杨晴贺 on 10/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CircleSpreadViewController.h"
#import "InteractiveTransition.h"
#import "CircleSpreadPresentViewController.h"
#import "Masonry.h"

@interface CircleSpreadViewController ()

@property (nonatomic,strong) UIButton *button ;

@end

@implementation CircleSpreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2"]] ;
    [self.view addSubview:imageView] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view) ;
    }] ;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom] ;
    self.button = button ;
    [button setTitle:@"点击或\n拖动我" forState:UIControlStateNormal] ;
    button.titleLabel.numberOfLines = 0 ;
    button.titleLabel.textAlignment = NSTextAlignmentCenter ;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter ;
    button.titleLabel.font = [UIFont systemFontOfSize:11.0f] ;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside] ;
    button.backgroundColor = [UIColor grayColor] ;
    button.layer.cornerRadius = 20 ;
    button.layer.masksToBounds = YES ;
    [self.view addSubview:button] ;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view).priorityLow() ;
        make.size.mas_equalTo(CGSizeMake(40, 40)) ;
        make.left.greaterThanOrEqualTo(self.view) ;
        make.top.greaterThanOrEqualTo(self.view).offset(64) ;
        make.bottom.right.lessThanOrEqualTo(self.view) ;
    }] ;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)] ;
    [button addGestureRecognizer:pan] ;
}

- (CGRect)frame{
    return _button.frame ;
}

- (void)present{
    CircleSpreadPresentViewController *pvc = [[CircleSpreadPresentViewController alloc]init] ;
    [self presentViewController:pvc animated:YES completion:nil] ;
}

- (void)pan:(UIPanGestureRecognizer *)panGesture{
    UIView *button = panGesture.view;
    CGPoint newCenter = CGPointMake([panGesture translationInView:panGesture.view].x + button.center.x - [UIScreen mainScreen].bounds.size.width / 2, [panGesture translationInView:panGesture.view].y + button.center.y - [UIScreen mainScreen].bounds.size.height / 2);
    [button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(newCenter).priorityLow();
    }];
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}
@end
