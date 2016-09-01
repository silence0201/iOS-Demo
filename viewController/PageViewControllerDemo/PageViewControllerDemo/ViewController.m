//
//  ViewController.m
//  PageViewControllerDemo
//
//  Created by 杨晴贺 on 9/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property(nonatomic,strong) UIPageViewController *pageVC;

@property(nonatomic,strong) NSMutableArray *viewControllers;

@property (nonatomic,assign) NSUInteger index ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0 ;
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
}



// 根据数组元素，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewControlller {
    return [self.viewControllers indexOfObject:viewControlller];
}

#pragma mark - UIPageViewControllerDataSource
// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (_index == [self.viewControllers count] - 1) {
        return nil;
    }
    _index++;
    return self.viewControllers[_index];
}
// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (_index == 0 ) {
        return nil;
    }
    _index--;
    
    return self.viewControllers[_index];
}

#pragma mark - UIPageViewControllerDelegate

// 开始翻页调用
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    NSLog(@"开始翻页");
}

// 翻页完成调用
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSLog(@"完成翻页");
    NSLog(@"%d",_index) ;
}

- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
    return UIInterfaceOrientationPortrait;
}


#pragma mark - lazy load

- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        
        /*
         UIPageViewControllerSpineLocationNone = 0, // 默认UIPageViewControllerSpineLocationMin
         UIPageViewControllerSpineLocationMin = 1,  // 书棱在左边
         UIPageViewControllerSpineLocationMid = 2,  // 书棱在中间，同时显示两页
         UIPageViewControllerSpineLocationMax = 3   // 书棱在右边
         */
        
        // 设置UIPageViewController的配置项
        NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey: @(UIPageViewControllerSpineLocationMin)} ;
        /*
         UIPageViewControllerNavigationOrientationHorizontal = 0, 水平翻页
         UIPageViewControllerNavigationOrientationVertical = 1    垂直翻页
         */
        /*
         UIPageViewControllerTransitionStylePageCurl = 0, // 书本效果
         UIPageViewControllerTransitionStyleScroll = 1 // Scroll效果
         */
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        
        _pageVC.dataSource = self;
        _pageVC.delegate = self;
        
        // 定义“这本书”的尺寸
        _pageVC.view.frame = self.view.bounds;
        
        // 要显示的第几页
        // 如果要同时显示两页，options参数要设置为UIPageViewControllerSpineLocationMid
        
        [self changeViewControllertoOrientation:UIInterfaceOrientationPortrait] ;

    }
    return _pageVC;
}

- (NSMutableArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            UIViewController *VC = [UIViewController new];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
            label.text = [NSString stringWithFormat:@"%d",i];
            [VC.view addSubview:label];
            VC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
            [_viewControllers addObject:VC];
        }
    }
    return _viewControllers;
}

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    if(orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown){
        [self changeViewControllertoOrientation:orientation] ;
        return UIPageViewControllerSpineLocationMin ;
    }else{
        [self changeViewControllertoOrientation:orientation] ;
        return UIPageViewControllerSpineLocationMid ;
    }
}

- (void)changeViewControllertoOrientation:(UIInterfaceOrientation)orientation{
    NSArray *vcs ;
    if (orientation == UIPageViewControllerSpineLocationMin) {
        vcs = @[self.viewControllers[_index]] ;
    }else{
        if(_index + 1 == [self.viewControllers count]){
            _index-- ;
        }
        vcs = @[self.viewControllers[_index],self.viewControllers[_index+1]] ;
    }
    [_pageVC setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    NSLog(@"%@",self.pageVC.viewControllers) ;
}

@end
