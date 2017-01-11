//
//  ViewController.m
//  CustomFlowLayoutDemo
//
//  Created by 杨晴贺 on 11/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "ViewController.h"
#import "SICustomFlowLayout.h"
#import "PhotoCell.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>{
    UICollectionView *_collectionView ;
}

@property (nonatomic,strong) NSMutableArray *dataArr ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    backImage.image = [UIImage imageNamed:@"11"] ;
    backImage.contentMode = UIViewContentModeScaleAspectFill ;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight] ;
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect] ;
    effectView.frame = backImage.bounds ;
    [backImage addSubview:effectView] ;
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]] ;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault] ;
    
    SICustomFlowLayout *layout = [[SICustomFlowLayout alloc]init] ;
    layout.itemSize=CGSizeMake(150, 150);
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout] ;
    _collectionView.delegate = self ;
    _collectionView.dataSource = self ;
    _collectionView.showsVerticalScrollIndicator = NO ;
    _collectionView.showsHorizontalScrollIndicator = NO ;
    _collectionView.backgroundView = backImage ;
    
    
    // 注册Cell
    [_collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"] ;
    
    [self.view addSubview:_collectionView] ;
}

-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr=[[NSMutableArray alloc] init];
        for (int i=0; i<16; i++) {
            [_dataArr addObject:[NSString stringWithFormat:@"%d",i+1]];
        }
    }
    return _dataArr;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1 ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath] ;
    cell.imageName = self.dataArr[indexPath.item] ;
    return cell ;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArr removeObjectAtIndex:indexPath.item];
    //TODO:  这个方法 特别注意 删除item的方法
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
}




@end
