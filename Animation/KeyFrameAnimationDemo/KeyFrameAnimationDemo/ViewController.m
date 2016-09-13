//
//  ViewController.m
//  KeyFrameAnimationDemo
//
//  Created by 杨晴贺 on 9/13/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *operateTitleArray ;

@property (nonatomic,strong) UIView *demoView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData] ;
    [self initView] ;
}

- (void)initData{
    _operateTitleArray = @[@"关键帧",@"路径",@"抖动"] ;
}

- (void)initView{
    self.title = @"基础动画演示" ;
    self.navigationController.navigationBar.backgroundColor = [UIColor cyanColor] ;
    
    if(_operateTitleArray && _operateTitleArray.count > 0){
        NSUInteger row = _operateTitleArray.count %4 == 0 ? _operateTitleArray.count / 4 :_operateTitleArray.count/4 +1 ;
        UIView *operateView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-(row*50+20), SCREEN_WIDTH, row*50+20)] ;
        [self.view addSubview:operateView] ;
        for(NSInteger i = 0 ; i<_operateTitleArray.count ; i++){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem] ;
            button.frame = [self rectForButtonAtIndex:i totalNum:_operateTitleArray.count] ;
            [button setTitle:_operateTitleArray[i] forState:UIControlStateNormal] ;
            button.tag = i + 100 ;
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside] ;
            button.backgroundColor = [UIColor orangeColor] ;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
            button.layer.cornerRadius = 4 ;
            [operateView addSubview:button] ;
        }
    }
    
    _demoView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100, 100, 100)] ;
    _demoView.backgroundColor = [UIColor blueColor] ;
    [self.view addSubview:_demoView] ;
}

- (CGRect)rectForButtonAtIndex:(NSInteger)index totalNum:(NSInteger)totalNum{
    // 每一行最多显示4个
    NSUInteger maxColumNum = 4 ;
    // 每个按钮的列间距
    CGFloat columMarign = 20 ;
    // 每个按钮的行间距
    CGFloat rowMargin = 20 ;
    
    // 每个按钮的宽度
    CGFloat width = (SCREEN_WIDTH - columMarign*5) / 4 ;
    //每个按钮的高度
    CGFloat height = 30 ;
    
    // 每个按钮的偏移
    CGFloat offsetX = columMarign+(index%maxColumNum)*(width+columMarign) ;
    CGFloat offsetY = rowMargin + (index/maxColumNum)*(height+rowMargin) ;
    
    return CGRectMake(offsetX, offsetY, width, height) ;
}

- (void)clickButton:(UIButton *)button{
    NSInteger flag = button.tag - 100 ;
    switch (flag) {
        case 0:
            [self keyFrameAnimation] ;
            break ;
        case 1:
            [self pathAnimation] ;
            break ;
        case 2:
            [self shakeAnimation] ;
            break ;
        default:
            break;
    }
}

// 关键帧动画
- (void)keyFrameAnimation{
    [_demoView.layer removeAllAnimations] ;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"] ;
    // 关键帧
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    // 设置关键帧
    animation.values = @[value0,value1,value2,value3,value4,value5] ;
    animation.duration = 2.0f ;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏 ;
    // 设置代理,用于检测动画的开始和结束
    animation.delegate = self ;
    [_demoView.layer addAnimation:animation forKey:@"frameAnimation"] ;
}

#pragma mark - keyFrameAnimation Delegate
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"开始动画") ;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"结束动画") ;
}

// path动画
- (void)pathAnimation{
    [_demoView.layer removeAllAnimations] ;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"] ;
    // 绘制贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)] ;
    // 设置路径
    animation.path = path.CGPath ;
    animation.delegate = self ;
    animation.duration = 2.0f ;
    [_demoView.layer addAnimation:animation forKey:@"pathAnimation"] ;
}

// 抖动效果
- (void)shakeAnimation{
    [_demoView.layer removeAllAnimations] ;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"] ;
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4] ;
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    animation.values = @[value1,value2,value3] ;
    animation.repeatCount = MAXFLOAT ;
    [_demoView.layer addAnimation:animation forKey:@"shakeAnimation"] ;
}

@end
