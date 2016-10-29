//
//  MagicMoveViewController.m
//  MagicMoveDemo
//
//  Created by 杨晴贺 on 29/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MagicMoveViewController.h"
#import "MagicMoveCell.h"
#import "MagicMovePushViewController.h"

@interface MagicMoveViewController ()

@end

@implementation MagicMoveViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100,100);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10) ;
    self = [super initWithCollectionViewLayout:layout];
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MagicMoveCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier] ;
    self.title = @"神奇的移动效果" ;
    self.collectionView.backgroundColor = [UIColor whiteColor] ;
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToRoot)] ;
    self.navigationItem.backBarButtonItem = back ;
}

- (void)backToRoot{
    self.navigationController.delegate = nil ;
    [self.navigationController popViewControllerAnimated:YES] ;
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MagicMoveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath] ;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.item % 2]] ;
    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.row]  ;
    return cell ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _currentIndexPath = indexPath ;
    MagicMovePushViewController *mc = [[MagicMovePushViewController alloc]init] ;
    self.navigationController.delegate = mc ;
    [self.navigationController pushViewController:mc animated:YES] ;
}

@end
