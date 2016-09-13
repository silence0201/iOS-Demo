//
//  ViewController.m
//  GroupAnimationDemo
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
    _operateTitleArray = @[@"同时",@"持续",@"不用组"] ;
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
    
    _demoView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100, 50, 50)] ;
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
            [self groupAnimation1] ;
            break ;
        case 1:
            [self groupAnimation2] ;
            break ;
        case 2:
            [self groupAnimation3] ;
            break ;
        default:
            break;
    }
}

// 同时
- (void)groupAnimation1{
    // 位移动画
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"] ;
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima1.values = @[value0,value1,value2,value3,value4,value5] ;
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"] ;
    anima2.fromValue = @(0.8f) ;
    anima2.toValue = @(2.0f) ;
    
    // 旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"] ;
    anima3.toValue = @(M_PI * 4) ;
    
    // 组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation] ;
    groupAnimation.animations = @[anima1,anima2,anima3] ;
    groupAnimation.duration = 4.0f ;
    
    [_demoView.layer addAnimation:groupAnimation forKey:@"groupAnimation"] ;
}

// 顺序执行
- (void)groupAnimation2{
    CFTimeInterval currentTime = CACurrentMediaTime() ;
    // 位移动画
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"] ;
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-75)];
    anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-75)];
    anima1.beginTime = currentTime ;
    anima1.duration = 1.0f ;
    anima1.fillMode = kCAFillModeForwards ;
    anima1.removedOnCompletion = NO ;
    [_demoView.layer addAnimation:anima1 forKey:@"aa"] ;
    
    // 缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"] ;
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.beginTime = currentTime + 1.0f ;
    anima2.duration = 1.0f ;
    anima2.fillMode = kCAFillModeForwards ;
    anima2.removedOnCompletion = NO ;
    [_demoView.layer addAnimation:anima2 forKey:@"bb"] ;
    
    // 旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"] ;
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = currentTime + 2.0f ;
    anima3.duration = 1.0f ;
    anima3.fillMode = kCAFillModeForwards ;
    anima3.removedOnCompletion = NO ;
    [_demoView.layer addAnimation:anima3 forKey:@"cc"] ;
    
}

// 不用组实现组的效果
- (void)groupAnimation3{
    //位移动画
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    anima1.duration = 4.0f;
    [_demoView.layer addAnimation:anima1 forKey:@"aa"];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.duration = 4.0f;
    [_demoView.layer addAnimation:anima2 forKey:@"bb"];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.duration = 4.0f;
    [_demoView.layer addAnimation:anima3 forKey:@"cc"];
}


@end
