//
//  CityViewCell.m
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CityViewCell.h"
#import "ItemViewCell.h"

@interface CityViewCell ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation CityViewCell{
    UICollectionView *_collectionView ;
    UICollectionViewFlowLayout *_flowLayout ;
}

- (void)setCityArray:(NSArray *)cityArray{
    
}

- (void)initUI{
    // 初始化布局
    _flowLayout = [[UICollectionViewFlowLayout alloc]init] ;
    _flowLayout.minimumInteritemSpacing = 15 ;
    _flowLayout.minimumLineSpacing = 10 ;
    _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10) ;   // cell离section的边距
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical ;
    _flowLayout.itemSize = CGSizeMake(90,35) ;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_flowLayout] ;
    
    //注册显示cell的类型
    UINib *cellNib=[UINib nibWithNibName:@"ItemViewCell" bundle:nil];
    
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"ItemViewCell"];
    
    _collectionView.delegate = self ;
    _collectionView.dataSource = self ;
    
    _collectionView.bounces=NO;
    _collectionView.scrollEnabled=NO;
    _collectionView.showsVerticalScrollIndicator=NO; //指示条
    _collectionView.backgroundColor=[UIColor whiteColor];
    
    [self addSubview:_collectionView] ;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1 ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _cityArray.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 重用cell
    ItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemViewCell" forIndexPath:indexPath] ;
    
    cell.cityName = _cityArray[indexPath.item] ;
    
    return cell  ;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate selectCityNameInCollectionCell:_cityArray[indexPath.item]] ;
}

@end
