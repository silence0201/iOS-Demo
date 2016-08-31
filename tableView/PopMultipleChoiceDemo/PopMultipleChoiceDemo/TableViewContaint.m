//
//  TableViewContaint.m
//  PopMultipleChoiceDemo
//
//  Created by 杨晴贺 on 8/31/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TableViewContaint.h"
#import "MultipleChoicCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface TableViewContaint ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *selectDataArray ;

@property (nonatomic,strong) NSMutableArray *backArray ;

@property (nonatomic,strong) NSString *confireString ;

@property (nonatomic,strong) UITableView *showTableView ;

@property (nonatomic,strong) UIView *showTableHeaderView ;

@property (nonatomic,assign) CGFloat recodeTableViewHeight ;

@end

@implementation TableViewContaint

#pragma mark - getter / setter

// 懒加载TableView
- (UITableView *)showTableView{
    if (_showTableView == nil) {
        _showTableView = [[UITableView alloc]init] ;
        CGFloat showTableViewHeight = (self.dataArray.count + 1) *44 ;
        
        if (showTableViewHeight > SCREEN_HEIGHT / 3 * 2) {
            showTableViewHeight = SCREEN_HEIGHT / 3 * 2 ;
        }
        self.recodeTableViewHeight = showTableViewHeight ;
        _showTableView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, showTableViewHeight) ;
    }
    return _showTableView ;
}

// 懒加载TableViewHeader
- (UIView *)showTableHeaderView{
    if(_showTableHeaderView == nil){
        _showTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)] ;
        
        // 取消按钮
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 80, 40)] ;
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal] ;
        
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal] ;
        CGPoint cancelCenter = CGPointMake(cancelBtn.center.x, _showTableHeaderView.center.y) ;
        [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside] ;
        [_showTableHeaderView addSubview:cancelBtn] ;
        cancelBtn.center = cancelCenter ;
        
        // 确认按钮
        UIButton *confireBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80 - 15, 10, 80 , 40)] ;
        [confireBtn setTitle:@"确认" forState:UIControlStateNormal] ;
        
        [confireBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal] ;
        CGPoint confireCenter = CGPointMake(confireBtn.center.x, _showTableHeaderView.center.y) ;
        [confireBtn addTarget:self action:@selector(confireClick) forControlEvents:UIControlEventTouchUpInside] ;
        [_showTableHeaderView addSubview:confireBtn] ;
        confireBtn.center = confireCenter ;
        
    }
    return _showTableHeaderView ;
}

-(NSMutableArray *)selectDataArray{
    if(_selectDataArray == nil){
        _selectDataArray = [NSMutableArray array] ;
        for (int i = 0; i<self.dataArray.count; i++) {
            [_selectDataArray addObject:@""] ;
        }
        
    }
    return _selectDataArray ;
}

-(NSMutableArray *)backArray{
    if (_backArray == nil) {
        _backArray = [NSMutableArray array] ;
    }
    return _backArray ;
}

-(void)setSelectArray:(NSArray *)selectArray{
    _selectArray = selectArray ;
    for (NSString *indexString in selectArray) {
        NSUInteger index = [indexString integerValue] ;
        [self.selectDataArray replaceObjectAtIndex:index withObject:self.dataArray[index]] ;
    }
    [self.backArray removeAllObjects] ;
    for(NSString *backString in self.selectDataArray){
        if (![backString isEqualToString:@""]) {
            [self.backArray addObject:backString] ;
        }
    }
    
    self.confireString = [self.backArray componentsJoinedByString:@","] ;
}

#pragma mark - Action
- (void)cancelClick{
    if(self.clickCancelBlock){
        self.clickCancelBlock() ;
    }
    [self dissMissView] ;
}

- (void)confireClick{
    if (self.clickConfireBlock) {
        self.clickConfireBlock(self.confireString,self.backArray) ;
    }
    [self dissMissView] ;
    
}

- (void)dissMissView{
    [UIView animateWithDuration:1 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut] ;
        self.showTableView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.recodeTableViewHeight);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview] ;
    }] ;
}

#pragma mark - tableView创建
static NSString *cellIndentifier = @"MultipleChoiceCell" ;
- (instancetype)initWithData:(NSArray *)dataArray andConfireBlock:(ClickConfireBlock)confireBlock andCancelBlock:(ClickCancelBlock)concelBlock{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.clickConfireBlock = confireBlock ;
        self.clickCancelBlock = concelBlock ;
        self.dataArray = dataArray ;
        [self.showTableView registerNib:[UINib nibWithNibName:@"MultipleChoicCell" bundle:nil] forCellReuseIdentifier:cellIndentifier] ;
        self.showTableView.dataSource = self ;
        self.showTableView.delegate = self ;
        self.showTableView.tableHeaderView = self.showTableHeaderView ;
        
        [self addSubview:self.showTableView] ;
        
        [UIView animateWithDuration:1 animations:^{
            self.showTableView.frame = CGRectMake(0, SCREEN_HEIGHT - self.recodeTableViewHeight, SCREEN_WIDTH, self.recodeTableViewHeight) ;
        }] ;
        
        UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow ;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        [currentWindow  addSubview:self] ;
    }
    return self ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MultipleChoicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier] ;
    
    cell.cellChoice.selected = [self.selectDataArray[indexPath.row] isEqualToString:@""]?NO:YES ;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds] ;
    cell.selectedBackgroundView.backgroundColor = [UIColor redColor] ;
    
    cell.cellLabel.text = self.dataArray[indexPath.row] ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
    
    MultipleChoicCell *cell = (MultipleChoicCell *)[tableView cellForRowAtIndexPath:indexPath] ;
    
    
    cell.cellChoice.selected = !cell.cellChoice.selected ;
    
    NSString *selectString ;
    if (cell.cellChoice.selected == YES) {
        selectString = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]] ;
    }else{
        selectString = @"" ;
    }
    
    [self.selectDataArray replaceObjectAtIndex:indexPath.row withObject:selectString] ;
    
    [self.backArray removeAllObjects] ;
    
    for(NSString *backString in self.selectDataArray){
        if (![backString isEqualToString:@""]) {
            [self.backArray addObject:backString] ;
        }
    }
    
    self.confireString = [self.backArray componentsJoinedByString:@","] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44 ;
}

#pragma mark - 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dissMissView] ;
}


@end
