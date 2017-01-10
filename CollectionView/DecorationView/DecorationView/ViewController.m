//
//  ViewController.m
//  DecorationView
//
//  Created by 杨晴贺 on 10/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "ViewController.h"
#import "MyLayout.h"
#import "MyCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyLayout *layout = [[MyLayout alloc]init] ;
    
    layout.minimumLineSpacing = 20 ;
    layout.minimumInteritemSpacing = 10 ;
    layout.sectionInset = UIEdgeInsetsMake(15, 10, 10, 10) ;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 6 * 10 - 20) / 3.0;
    layout.itemSize = CGSizeMake(width, width) ;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical ;
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    backImage.image = [UIImage imageNamed:@"22"] ;
    backImage.contentMode = UIViewContentModeScaleAspectFill ;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight] ;
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect] ;
    effectView.frame = backImage.bounds ;
    [backImage addSubview:effectView] ;
   
    
    // CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout] ;
    collectionView.backgroundView = backImage ;
    [collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"] ;
    
    
    
    collectionView.dataSource = self ;
    [self.view addSubview:collectionView] ;
}

#pragma mark --- DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 6 ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath] ;
    return cell ;
}



@end
