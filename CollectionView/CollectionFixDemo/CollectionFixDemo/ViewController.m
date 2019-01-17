//
//  ViewController.m
//  CollectionFixDemo
//
//  Created by Silence on 2019/1/17.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "FixCollectionLayout.h"
#import "FixCollectionViewCell.h"

static NSString *cellIdentifier = @"FixCollectionViewCell";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,FixCollectionLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FixCollectionLayout *fixCollectionLayout = [[FixCollectionLayout alloc] init];
    fixCollectionLayout.delegate = self;
    
    CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height + 44 ;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100) collectionViewLayout:fixCollectionLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.bounces = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.directionalLockEnabled = YES;
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.collectionView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 40);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 200;
}

/**
 *  每个section元素的个数，注意section 0的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FixCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 0.5;
    cell.text = [NSString stringWithFormat:@"%@+%@", @(indexPath.section), @(indexPath.row)];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"Section:%@ Row:%@", @(indexPath.section), @(indexPath.row));
}


@end
