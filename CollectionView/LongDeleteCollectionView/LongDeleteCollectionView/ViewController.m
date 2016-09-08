//
//  ViewController.m
//  LongDeleteCollectionView
//
//  Created by 杨晴贺 on 9/8/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,CollectionViewDelegate>{
    NSMutableArray *_photosArray ;
    BOOL showing ;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"长安删除" ;
    
    [self initData] ;
    [self initUI] ;
    
}

- (void)initData{
    _photosArray =[ @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"] mutableCopy];
    showing = YES ;
}

- (void)initUI{
    UICollectionViewFlowLayout  *flowLayout = [[UICollectionViewFlowLayout alloc]init] ;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0) ;
    flowLayout.minimumLineSpacing = 0 ;
    flowLayout.minimumInteritemSpacing = 0 ;
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 60) ;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//滚动方向
    
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    self.collectionView.collectionViewLayout = flowLayout ;
    
    // 设置代理
    self.collectionView.backgroundColor = [UIColor whiteColor] ;
    
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView.delegate = self ;
    self.collectionView.dataSource = self ;
    
    
    
}

#pragma mark - CollectionViewDelegate
- (void)hideAllDeleteBtn{
    if(!showing){
        showing = YES ;
        [self.collectionView reloadData] ;
    }
}

- (void)showAllDeleteBtn{
    showing = NO ;
    [self.collectionView reloadData] ;
}

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath{
    if(_photosArray.count == 1){
        return;
    }
    [self.collectionView performBatchUpdates:^{
        [_photosArray removeObjectAtIndex:indexPath.item] ;
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]] ;
    } completion:^(BOOL finished) {
        [self.collectionView reloadData] ;
    }] ;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1 ;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _photosArray.count ;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell" ;
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath] ;
    cell.path = indexPath ;
    cell.btn.hidden = showing?YES:NO ;
    cell.imageView.userInteractionEnabled = showing?NO:YES ;
    cell.delegate = self ;
    cell.imageView.image = [UIImage imageNamed:_photosArray[indexPath.item]] ;
    cell.userInteractionEnabled = YES ;
    
    return cell ;
}

#pragma mark -UICollectionViewDelegate
// cell是否可以删除
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES ;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"选择%ld",indexPath.row);
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/3.0, SCREEN_WIDTH/3.0);
}

@end
