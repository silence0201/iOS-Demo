//
//  ViewController.m
//  CollectionSimpleDemo
//
//  Created by 杨晴贺 on 9/8/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+RandomColor.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init] ;
    layout.itemSize = CGSizeMake(50, 50) ;  // 每个item的大小
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10) ;   // cell离section的边距
    
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal ; // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical ;
    layout.minimumLineSpacing = 10 ;  // 上下相邻的cell的最小行距
    layout.minimumInteritemSpacing = 5 ; // 左右相邻测cell得最小行距
    
    self.collectionView.collectionViewLayout = layout ;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"] ;  // 注册头
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"] ;
    
    self.collectionView.backgroundColor = [UIColor whiteColor] ;
    self.collectionView.delegate = self ;
    self.collectionView.dataSource = self ;
    self.collectionView.allowsMultipleSelection = YES ; // 是否可以多选
}

#pragma mark - UICollectionViewDelegateFlowLayout
// 尾的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(60, 30) ;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(60, 50) ;
}

#pragma mark - UICollectionViewDataSource
// 有多少节
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5 ;
}

// 每节有多少块
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20 ;
}

// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath] ;
    cell.backgroundColor = [UIColor randomColor] ;
    cell.selectedBackgroundView = [[UIView alloc]init] ;
    cell.selectedBackgroundView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.5] ;
    return cell ;
}

// 设置header和footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view ;
    if(kind == UICollectionElementKindSectionHeader){
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath] ;
        view.backgroundColor = [UIColor orangeColor] ;
        UILabel *label = (UILabel *)[view viewWithTag:100] ;
        label.text = [NSString stringWithFormat:@"第%ld组",(long)indexPath.section] ;
        return view ;
    }else if(kind == UICollectionElementKindSectionFooter){
        view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        view.backgroundColor=[UIColor greenColor];
        return view;
    }
    return nil ;
}

#pragma mark - UICollectionViewDelegate
// 取消选择哪一个
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选中%@",indexPath) ;
}

// 选中哪一个
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中%@",indexPath) ;
}

@end
