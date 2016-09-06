//
//  ViewController.m
//  SelectListDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "SISelectListItem.h"
#import "SISelectListViewController.h"


@interface ViewController ()

@property (nonatomic,strong) SISelectListViewController *selectVC ;
@property (nonatomic,strong) NSMutableArray *selectArray ;

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"弹出选择效果" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarBtnClick)] ;
    
    self.selectArray = [NSMutableArray array] ;
    
    [self loadListItems] ;
}

- (void)loadListItems{
    NSArray *images = @[[UIImage imageNamed:@"main_add_friend"],[UIImage imageNamed:@"main_code_friend"]] ;
    NSArray *titles = @[@"添加朋友",@"扫一扫"] ;
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SISelectListItem *item = [[SISelectListItem alloc]initWithIconImage:images[idx] andTitle:titles[idx]] ;
        [_selectArray addObject:item] ;
    }] ;
    
}

- (void)rightBarBtnClick{
    self.selectVC = [[SISelectListViewController alloc]initWithItem:_selectArray] ;
    _selectVC.backgroudName = @"activity_add_bg" ;
    _selectVC.showListViewController = self ;
    typeof(self) __weak weakSelf = self ;
    _selectVC.clickBlock = ^(NSInteger selectIndex){
        NSLog(@"%zi",selectIndex) ;
        if(selectIndex == 0){
            weakSelf.label.text = @"添加朋友" ;
        }else{
            weakSelf.label.text = @"扫一扫" ;
        }
    } ;
    [_selectVC show] ;
    
}

@end
