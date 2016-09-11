//
//  ViewController.m
//  BaseAnimationDemo
//
//  Created by 杨晴贺 on 9/11/16.
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
    _operateTitleArray = @[@"位移-1",@"位移-2",@"位移-3",@"透明度",@"缩放",@"旋转-1",@"旋转-2",@"背景色"] ;
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
            [self positionAnimation] ;
            break;
        case 1:
            [self positionAnimation2] ;
            break ;
        case 2:
            [self positionAnimation3] ;
            break ;
        case 3:
            [self opacityAnimation] ;
            break ;
        case 4:
            [self scaleAnimation] ;
            break ;
        case 5:
            [self rotateAnimation] ;
            break ;
        case 6:
            [self rotateAnimation2] ;
            break ;
        case 7:
            [self backgroundAnimation] ;
            break ;
        default:
            break;
    }
}

// 位移动画-1
- (void)positionAnimation{
    // 使用CABasicAnimation创建基础动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"] ;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-75)] ;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH,SCREEN_HEIGHT/2-75)] ;
    animation.duration = 2.0f ;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn] ;
    //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_demoView.layer addAnimation:animation forKey:@"positionAnimation"] ;
}

// 位移动画-2
- (void)positionAnimation2{
    // 使用UIViewAnimation代码块调用
    _demoView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 100, 100) ;
    [UIView animateWithDuration:2.0 animations:^{
        _demoView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2 - 50, 100, 100) ;
    } completion:^(BOOL finished) {
        _demoView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 100, 100)  ;
    }] ;
}

// 位移动画-3
- (void)positionAnimation3{
    _demoView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 100, 100) ;
    [UIView beginAnimations:nil context:nil] ;
    [UIView setAnimationDuration:2.0] ;
    _demoView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50, 100, 100) ;
    [UIView commitAnimations] ;
}

// 透明度动画
- (void)opacityAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"] ;
    animation.fromValue = [NSNumber numberWithFloat:1.0f] ;
    animation.toValue = [NSNumber numberWithFloat:0.2f] ;
    animation.duration = 1.0f ;
    [_demoView.layer addAnimation:animation forKey:@"opacityAnimaction"] ;
}

// 缩放动画
- (void)scaleAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"] ;
    animation.toValue = [NSNumber numberWithFloat:2.0f] ;
    animation.duration = 2.0f ;
    [_demoView.layer addAnimation:animation forKey:@"scaleAnimation"] ;
}

// 旋转动画-1
- (void)rotateAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"] ;
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    animation.duration = 1.0f;
    [_demoView.layer addAnimation:animation forKey:@"rotateAnimation"];
}
// 旋转动画-2
- (void)rotateAnimation2{
    _demoView.transform = CGAffineTransformMakeRotation(0) ;
    [UIView animateWithDuration:2.0 animations:^{
        _demoView.transform = CGAffineTransformMakeRotation(M_PI) ;
    } completion:^(BOOL finished) {
        
    }] ;
}

// 背景色变化动画
- (void)backgroundAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"] ;
    animation.toValue = (id)([UIColor grayColor].CGColor) ;
    animation.duration = 1.0f ;
    [_demoView.layer addAnimation:animation forKey:@"backgroundAnimation"] ;
    
}


@end
