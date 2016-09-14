//
//  ViewController.m
//  WaterFlowLayoutDemo
//
//  Created by 杨晴贺 on 9/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"
#import "SICollectionReusableView.h"
#import "SICollectionViewCell.h"
#import "SIWaterFlowLayout.h"
#import "MJExtension.h"

static CGFloat const bottomHeight = 30 ;

@interface ViewController ()<SIWaterFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *nameArray ;
@property (nonatomic,strong) NSArray *dataArray ;

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData] ;
    
    [self initCollectionView] ;
    
    
    [self.collectionView reloadData] ;
}

#pragma mark - Private Method
- (void)initData{
    NSArray *plistOneArray = [DataModel objectArrayWithFilename:@"1.plist"];
    NSArray *plistTwoArray = [DataModel objectArrayWithFilename:@"2.plist"];
    NSArray *plistThreeArray = [DataModel objectArrayWithFilename:@"3.plist"];
    _dataArray = @[plistOneArray,plistTwoArray,plistThreeArray] ;
    _nameArray = @[@"第一组", @"第二组", @"第三组"];
}

- (void)initCollectionView{
    SIWaterFlowLayout *flowLayout = [[SIWaterFlowLayout alloc]init] ;
    flowLayout.itemSpace = 10 ;
    flowLayout.lineSpace = 10 ;
    flowLayout.colCount = 3 ;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10) ;
    flowLayout.delegate = self ;
    self.collectionView.collectionViewLayout = flowLayout ;
    self.collectionView.delegate = self ;
    self.collectionView.dataSource = self ;
    self.collectionView.backgroundColor = [UIColor whiteColor] ;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SICollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"] ;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SICollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"] ;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SICollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"fooderView"] ;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArray.count ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataArray[section] count] ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath] ;
    cell.model = _dataArray[indexPath.section][indexPath.item] ;
    return cell ;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath] ;
        headerView.title = [NSString stringWithFormat:@"header:%@",_nameArray[indexPath.section]] ;
        return headerView ;
    }else{
        SICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"fooderView" forIndexPath:indexPath] ;
        footerView.title = [NSString stringWithFormat:@"footer:%@",_nameArray[indexPath.section]] ;
        return footerView ;
        return nil ;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 这里是处理点击事件
    NSLog(@"%ld===%ld",indexPath.section,indexPath.item) ;
}

#pragma mark -SIWaterFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SIWaterFlowLayout *)waterFlowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    DataModel *mo = _dataArray[indexPath.section][indexPath.item] ;
    return mo.h / mo.w *width + bottomHeight ;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SIWaterFlowLayout *)waterFlowLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(self.view.frame.size.width - 20, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SIWaterFlowLayout *)waterFlowLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.frame.size.width - 20, 40);
}

@end
