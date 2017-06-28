//
//  ViewController.m
//  CycleLoopScrollViewDemo
//
//  Created by 杨晴贺 on 2017/6/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "CycleLoopScrollView.h"

@interface ViewController ()<CycleLoopScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *contentViewDataArr ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CycleLoopScrollView *scrollView = [[CycleLoopScrollView alloc]initWithFrame:CGRectMake(0, 0, 300, 300) animationScrollDuration:2] ;
    scrollView.center = self.view.center ;
    scrollView.delegate = self ;
    [self.view addSubview:scrollView] ;
}

- (NSMutableArray *)contentViewDataArr {
    if (!_contentViewDataArr) {
        _contentViewDataArr = [NSMutableArray array] ;
        NSArray *colorArray = @[[UIColor cyanColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor purpleColor]];
        for (int i = 0; i < 3; i++) {
            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
            tempLabel.backgroundColor = colorArray[i];
            tempLabel.textAlignment   = NSTextAlignmentCenter;
            tempLabel.text            = [NSString stringWithFormat:@"%d",i];
            tempLabel.font            = [UIFont boldSystemFontOfSize:50];
            [_contentViewDataArr addObject:tempLabel];
        }
    }
    return _contentViewDataArr ;
}

#pragma mark - CycleLoopScrollViewDelegate 
- (NSInteger)numberOfCountentViewInCycleLoopScrollView:(CycleLoopScrollView *)loopScrollView {
    return self.contentViewDataArr.count ;
}

- (UIView *)cycleLoopScrollView:(CycleLoopScrollView *)cycleLoopScrollView contentViewAtIndex:(NSInteger)index {
    return self.contentViewDataArr[index] ;
}

- (void)cycleLoopScrollView:(CycleLoopScrollView *)cycleLoopScrollView currentContentViewAtIndex:(NSInteger)index {
    NSLog(@"----当前-----%ld",index);
}

- (void)cycleLoopScrollView:(CycleLoopScrollView *)cycleLoopScrollView didSelectContentViewAtIndex:(NSInteger)index {
    NSLog(@"----点击-----%ld",index);
}

@end
