//
//  ViewController.m
//  CollectViewAlignDemo
//
//  Created by 杨晴贺 on 09/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "ViewController.h"
#import "SICollectViewAlignLayout.h"
#import "UIColor+RandomColor.h"

static NSString *const kCellIdentifier = @"CellIdentifier" ;
static NSString *const kHeaderIdentifier = @"HeaderIdentifier" ;
static NSString *const kFooterIdentifier = @"FooterIdentifier" ;
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SICollectViewAlignLayout *layout = [[SICollectViewAlignLayout alloc]initWithAlignType:SICollectViewAlignCenter] ;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout] ;
    collectionView.backgroundColor = [UIColor whiteColor] ;
    [self.view addSubview:collectionView] ;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier] ;
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier] ;
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterIdentifier];
    collectionView.delegate = self ;
    collectionView.dataSource = self ;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 50);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView =nil;
    
    if (kind ==UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerV = (UICollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier forIndexPath:indexPath];
        headerV.backgroundColor = [UIColor yellowColor];
        reusableView = headerV;
    }
    if (kind ==UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerV = (UICollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterIdentifier forIndexPath:indexPath];
        footerV.backgroundColor = [UIColor blueColor];
        reusableView = footerV;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor] ;
    return cell;
}

#pragma mark - UICollectionViewDelegateLeftAlignedLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(((indexPath.row * 35) % 120) + 60, 60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 25;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}




@end
