//
//  SwipeView.m
//  TableSwipeCustom
//
//  Created by 杨晴贺 on 20/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SwipeView.h"
#import "SwipeButton.h"


// 动画节奏算法
static inline CGFloat mgEaseLinear(CGFloat t, CGFloat b, CGFloat c) {
    return c*t + b;
}

static inline CGFloat mgEaseInQuad(CGFloat t, CGFloat b, CGFloat c) {
    return c*t*t + b;
}
static inline CGFloat mgEaseOutQuad(CGFloat t, CGFloat b, CGFloat c) {
    return -c*t*(t-2) + b;
}
static inline CGFloat mgEaseInOutQuad(CGFloat t, CGFloat b, CGFloat c) {
    if ((t*=2) < 1) return c/2*t*t + b;
    --t;
    return -c/2 * (t*(t-2) - 1) + b;
}
static inline CGFloat mgEaseInCubic(CGFloat t, CGFloat b, CGFloat c) {
    return c*t*t*t + b;
}
static inline CGFloat mgEaseOutCubic(CGFloat t, CGFloat b, CGFloat c) {
    --t;
    return c*(t*t*t + 1) + b;
}
static inline CGFloat mgEaseInOutCubic(CGFloat t, CGFloat b, CGFloat c) {
    if ((t*=2) < 1) return c/2*t*t*t + b;
    t-=2;
    return c/2*(t*t*t + 2) + b;
}
static inline CGFloat mgEaseOutBounce(CGFloat t, CGFloat b, CGFloat c) {
    if (t < (1/2.75)) {
        return c*(7.5625*t*t) + b;
    } else if (t < (2/2.75)) {
        t-=(1.5/2.75);
        return c*(7.5625*t*t + .75) + b;
    } else if (t < (2.5/2.75)) {
        t-=(2.25/2.75);
        return c*(7.5625*t*t + .9375) + b;
    } else {
        t-=(2.625/2.75);
        return c*(7.5625*t*t + .984375) + b;
    }
};
static inline CGFloat mgEaseInBounce(CGFloat t, CGFloat b, CGFloat c) {
    return c - mgEaseOutBounce (1.0 -t, 0, c) + b;
};

static inline CGFloat mgEaseInOutBounce(CGFloat t, CGFloat b, CGFloat c) {
    if (t < 0.5) return mgEaseInBounce (t*2, 0, c) * .5 + b;
    return mgEaseOutBounce (1.0 - t*2, 0, c) * .5 + c*.5 + b;
};

@interface SwipeView ()

@property (nonatomic,strong) UIView *containView ;  // 容器View
@property (nonatomic,strong) NSArray *buttonArray ;  // 排列后的buttons

@end

@implementation SwipeView

- (instancetype)initWithButtons:(NSArray *)buttons fromRight:(BOOL)fromRight cellHeght:(CGFloat)cellHeight{
    CGFloat containWidth = 0 ;
    // 计算buttons的总宽度
    for (SwipeButton *button in buttons){
        containWidth += MAX(button.frame.size.width, cellHeight) ;
    }
    
    if(self = [super initWithFrame:CGRectMake(0, 0, containWidth, cellHeight)]){
        self.duration = 0.3 ;
        self.easingFunction = SwipeEasingFunctionCubicOut ;
        
        // 若是右滑,即将数组的最后一个元素放在swipeView的最后
        self.buttonArray = fromRight ? [[buttons reverseObjectEnumerator] allObjects] : buttons;
        [self addSubview:self.containView];
        
        CGFloat offset = 0.0 ;
        for (SwipeButton *button in self.buttonArray){
            button.frame = CGRectMake(offset, 0, MAX(button.frame.size.width, cellHeight), cellHeight) ;
            offset += button.frame.size.width ;
            // 防止重用问题,移除点击事件
            [button removeTarget:self action:@selector(touchSwipeButton:) forControlEvents:UIControlEventTouchUpInside] ;
            [button addTarget:self action:@selector(touchSwipeButton:) forControlEvents:UIControlEventTouchUpInside] ;
            //直接用addSubview会覆盖左滑的动画效果
            [self.containView insertSubview:button atIndex:fromRight ? self.containView.subviews.count : 0];
        }
    }
    return self ;
}

#pragma mark - Action
- (void)touchSwipeButton:(SwipeButton *)btn{
    btn.touchBlock();
}

#pragma mark - Lazy Load
- (UIView *)containView{
    if(!_containView){
        _containView = [[UIView alloc] initWithFrame:self.bounds];
        _containView.backgroundColor = [UIColor clearColor];
        _containView.clipsToBounds = YES;
    }
    return _containView;
}

- (NSArray *)buttonArray{
    if(!_buttonArray){
        _buttonArray = [NSArray array];
    }
    return _buttonArray;
}


#pragma mark - Animations
// 手势动画效果
-(CGFloat)value:(CGFloat)elapsed duration:(CGFloat)duration from:(CGFloat)from to:(CGFloat)to
{
    CGFloat t = MIN(elapsed/duration, 1.0f);
    if (t == 1.0) {
        return to;
    }
    CGFloat (*easingFunction)(CGFloat t, CGFloat b, CGFloat c) = 0;
    switch (_easingFunction) {
        case SwipeEasingFunctionLinear: easingFunction = mgEaseLinear; break;
        case SwipeEasingFunctionQuadIn: easingFunction = mgEaseInQuad;;break;
        case SwipeEasingFunctionQuadOut: easingFunction = mgEaseOutQuad;;break;
        case SwipeEasingFunctionQuadInOut: easingFunction = mgEaseInOutQuad;break;
        case SwipeEasingFunctionCubicIn: easingFunction = mgEaseInCubic;break;
        default:
        case SwipeEasingFunctionCubicOut: easingFunction = mgEaseOutCubic;break;
        case SwipeEasingFunctionCubicInOut: easingFunction = mgEaseInOutCubic;break;
        case SwipeEasingFunctionBounceIn: easingFunction = mgEaseInBounce;break;
        case SwipeEasingFunctionBounceOut: easingFunction = mgEaseOutBounce;break;
        case SwipeEasingFunctionBounceInOut: easingFunction = mgEaseInOutBounce;break;
    }
    return (*easingFunction)(t, from, to - from);
}

// swipeView的弹出动画效果
- (void)swipeViewAnimationFromRight:(BOOL)fromRight effect:(CGFloat)t cellHeight:(CGFloat)cellHeight
{
    switch (self.mode)
    {
        case SwipeViewTransfromModeDefault:break; //默认的效果
        case SwipeViewTransfromModeBorder:{ //渐出
        
            CGFloat selfWidth = self.bounds.size.width;
            CGFloat offsetX = 0;
            
            for (SwipeButton *button in self.buttonArray){
                CGRect frame = button.frame;
                CGFloat x = fromRight ? offsetX * t :(selfWidth - MAX(frame.size.width, cellHeight) - offsetX) * (1.0 - t) + offsetX;
                button.frame = CGRectMake(x, 0,  MAX(frame.size.width, cellHeight), cellHeight);
                offsetX += MAX(frame.size.width, cellHeight);
            }
        }
            break;;
        case SwipeViewTransfromMode3D: {   //3D
            const CGFloat invert = fromRight ? -1.0 : 1.0;
            const CGFloat angle = M_PI_2 * (1.0 - t) * invert;
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -1.0/400.0f;
            const CGFloat dx = -_containView.frame.size.width * 0.5 * invert;
            const CGFloat offset = dx * 2 * (1.0-t);
            transform = CATransform3DTranslate(transform, dx - offset, 0, 0);
            transform = CATransform3DRotate(transform, angle, 0.0, 1.0, 0.0);
            transform = CATransform3DTranslate(transform, -dx, 0, 0);
            self.containView.layer.transform = transform;
        }
            break;
    }
}


- (void)removeAllSubViewsAtView:(UIView *)view{
    while (view.subviews.count) {
        [[view.subviews lastObject] removeFromSuperview];
    }
}


@end
