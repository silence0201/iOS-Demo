//
//  ViewController.m
//  SIFixedHeaderFlowLayout
//
//  Created by 杨晴贺 on 18/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "ViewController.h"
#import "ReusableView.h"
#import "SIFixedHeaderFlowLayout.h"
#import "UIColor+RandomColor.h"

static NSString *cellID = @"cellID";
static NSString *headerID = @"headerID";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.view addSubview:self.collectionView] ;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        SIFixedHeaderFlowLayout *layout = [SIFixedHeaderFlowLayout new];
        layout.itemSize = CGSizeMake(100, 100);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout] ;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
        _collectionView.delegate = self ;
        _collectionView.dataSource = self ;
    }
    return _collectionView ;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==2) {
        return 0;
    }
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 0) {
        ReusableView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        header.backgroundColor = [[UIColor randomColor] colorWithAlphaComponent:0.4] ;
        header.text = [NSString stringWithFormat:@"第%ld个分区的header",indexPath.section];
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section>0) {
        return CGSizeMake(0, 44);
    }
    return CGSizeZero;
}




@end
