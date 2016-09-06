//
//  SISelectListViewController.m
//  SelectListDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SISelectListViewController.h"
#import "SISelectListCell.h"
#import "SISelectListItem.h"


@interface SISelectListViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *selectListView ;
@property (nonatomic,strong) UITableView *selectListTableView ;

@end

@implementation SISelectListViewController

- (instancetype)initWithItem:(NSArray<SISelectListItem *> *)items{
    if (self = [super init]) {
        self.items = items ;
        self.alphaComponent = 0.25 ;
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:_alphaComponent] ;
    
    [self createSelectListView] ;
    
}

- (void)createSelectListView{
    self.selectListView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 140, 64 + 5, 130, 5 + 40 * _items.count)] ;
    
    [self.view addSubview:_selectListView] ;
    
    UIImage *bgImage = [UIImage imageNamed:_backgroudName] ;
    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(25, 10, 10, 22)] ;
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _selectListView.frame.size.width, _selectListView.frame.size.height)] ;
    bgImageView.image = bgImage ;
    [_selectListView addSubview:bgImageView] ;
    
    self.selectListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, _selectListView.frame.size.width, _selectListView.frame.size.height) style:UITableViewStylePlain] ;
    self.selectListTableView.delegate = self ;
    self.selectListTableView.dataSource = self ;
    self.selectListTableView.scrollEnabled = NO ;
    self.selectListTableView.backgroundColor = [UIColor clearColor] ;
    [_selectListView addSubview:_selectListTableView] ;
    
    if ([_selectListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_selectListTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_selectListTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_selectListTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)] ;
    dismissTap.delegate = self ;
    [self.view addGestureRecognizer:dismissTap] ;
}

#pragma mark - TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID" ;
    SISelectListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID] ;
    if (!cell) {
        cell = [[SISelectListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] ;
        cell.backgroundColor = [UIColor clearColor] ;
    }
    SISelectListItem *item = _items[indexPath.row] ;
    cell.item = item ;
    
    return cell ;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
    [self dismissWithAnimate:NO] ;
    
    if(self.clickBlock){
        self.clickBlock(indexPath.row) ;
    }
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.selectListView]) {
        return NO ;
    }
    return YES ;
}


- (void)dismiss{
    [self dismissWithAnimate:YES] ;
}

#pragma mark - Public Method
- (void)show{
    if (floor(NSFoundationVersionNumber)>= NSFoundationVersionNumber_iOS_8_0) {
        // ios 8
        self.modalPresentationStyle = UIModalPresentationCustom ;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve ;
    }else{
        UIViewController *root = _showListViewController ;
        while (root.parentViewController) {
            root = root.parentViewController;
        }
        root.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve ;
    [_showListViewController presentViewController:self animated:YES completion:nil] ;
}

- (void)dismissWithAnimate:(BOOL)animate
{
    if (animate) {
        //设置缩放的原点(必须配置)
        //这个point，应该是按照比例来的。0是最左边，1是最右边
        [self setAnchorPoint:CGPointMake(0.9, 0) forView:_selectListView];
        
        [UIView animateWithDuration:0.3 animations:^{
            _selectListView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }else
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGRect oldFrame = view.frame;
    view.layer.anchorPoint = anchorPoint;
    view.frame = oldFrame;
}


@end
