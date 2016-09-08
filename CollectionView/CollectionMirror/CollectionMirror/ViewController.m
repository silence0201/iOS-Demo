//
//  ViewController.m
//  CollectionMirror
//
//  Created by 杨晴贺 on 9/8/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "MyLayout.h"
#import "MyView.h"

#define NEED_WIDTH [UIScreen mainScreen].bounds.size.width * 0.6
#define NEED_HEIGHT [UIScreen mainScreen].bounds.size.height * 0.2
@interface ViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyLayout *layout = [[MyLayout alloc]init] ;
    layout.sectionInset = UIEdgeInsetsMake(10, 80, NEED_HEIGHT, 80) ;
    layout.minimumLineSpacing = 50.0 ;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    self.collectionView.delegate = self ;
    self.collectionView.dataSource = self ;
    self.collectionView.allowsSelection = NO ;
    self.collectionView.allowsMultipleSelection = NO ;
    self.collectionView.collectionViewLayout = layout ;
    self.collectionView.backgroundColor = [UIColor blackColor] ;
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"] ;
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1 ;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath] ;
    cell.backgroundColor = [UIColor clearColor] ;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, NEED_WIDTH, NEED_WIDTH*1.2) ];
     ;
    imageView.image = [UIImage imageNamed:self.imageArray[indexPath.item]] ;
    imageView.contentMode = UIViewContentModeScaleToFill ;
    MyView *vi = [[MyView alloc]initWithFrame:CGRectMake(0, 0, NEED_WIDTH, NEED_WIDTH*1.2)] ;
    [vi addSubview:imageView] ;
    [vi setInverterImage] ;
    [cell.contentView addSubview:vi] ;
    
    return cell ;
    
}

#pragma  mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(NEED_WIDTH, NEED_WIDTH*1.2);
}

#pragma mark - lazy load
- (NSArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = @[@"1",@"2",@"3",@"4",@"5"] ;
    }
    return _imageArray ;
}

- (BOOL)prefersStatusBarHidden{
    return YES ;
}

@end
