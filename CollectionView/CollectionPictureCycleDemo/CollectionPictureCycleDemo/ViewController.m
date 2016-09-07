//
//  ViewController.m
//  CollectionPictureCycleDemo
//
//  Created by 杨晴贺 on 9/7/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "SIImageCell.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic,strong) NSArray *images ;
@property (nonatomic,strong) NSTimer *timer ;
@property (nonatomic,assign) NSInteger currentIndex ;

@end

@implementation ViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置cell的大小
    self.flowLayout.itemSize = self.collectionView.bounds.size ;
    // 设置列间距
    self.flowLayout.minimumLineSpacing = 0 ;
    self.flowLayout.minimumInteritemSpacing = 0 ;
    // 设置滚动方向
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    // 设置分页效果
    self.collectionView.pagingEnabled = YES ;
    // 隐藏滚动条
    self.collectionView.showsVerticalScrollIndicator = NO ;
    self.collectionView.showsHorizontalScrollIndicator = NO ;
    // 关闭弹簧效果
    self.collectionView.bounces = NO ;
    
    // 默认滚动到中间哪一组的第0个cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0] ;
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO] ;
}


// 当控制器的view已经完全显示出来的时候进行调用
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated] ;
    //设置默认第0个
    self.currentIndex = 0 ;
    // 添加定时器
    [self timer] ;
}

#pragma mark - UIScrollViewDelegate方法
// 当用户开始拖拽时停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate] ;
    self.timer = nil ;
}

// 当手动滚动时,当cell完全停下来  Decelerating 降速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scroolingStop:scrollView] ;
}

// 停止拖拽,重新开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self timer] ;
}

// 动画去滚动每一页,当一页滚动完成之后就会来调用一次此方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // 自动回到第一组对应的item
    [self scroolingStop:scrollView] ;
}

#pragma mark - 数据源方法
// 返回有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2 ;
}

// 返回有多少个各自
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count ;
}

// 返回对应的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SIImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath] ;
    cell.tag = indexPath.item ;
    //设置数据
    cell.imagePath = self.images[indexPath.item] ;
    cell.currentPath = indexPath ;
    // 返回cell
    return cell ;
}

#pragma mark - Action
// 下一张的定时器方法
- (void)next{
    if(self.currentIndex == imageCount-1){
        // 如果是最后一项,需要把索引恢复为0
        self.currentIndex = 0 ;
        // 滚动到下一组的第一个cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1] ;
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES] ;
    }else{
        self.currentIndex++ ;
        NSIndexPath  *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0] ;
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES] ;
    }
}

// 当停止拖动的时候调用
- (void)scroolingStop:(UIScrollView *)scrollView{
    // 计算当前的滚动的位置
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width ;
    // 计算是第几张图片
    NSInteger currentPage = page % imageCount ;
    _currentIndex = currentPage ;
    // 获取当前滚动的位置cell的索引
    NSIndexPath *currentIndex = [self.collectionView indexPathForItemAtPoint:scrollView.contentOffset] ;
    
    if(currentIndex.section != 0){
        // 当前不是第一组回到第一组第一个cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentPage inSection:0] ;
        //滚动时不要开启动画
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO] ;
    }
}

#pragma mark - 懒加载,获取数据
- (NSArray *)images{
    if(_images == nil){
        NSMutableArray *array = [NSMutableArray array] ;
        for(NSInteger i= 0 ; i<imageCount;i++){
            NSString *path = [NSString stringWithFormat:@"%ld",i+1] ;
            [array addObject:path] ;
        }
        _images = array ;
    }
    return _images ;
}

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(next) userInfo:nil repeats:YES] ;
        // 把定时器添加到当前的运行循环中,同时改变模式
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer ;
}




@end
