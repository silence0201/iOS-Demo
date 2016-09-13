//
//  ViewController.m
//  DynamicCellDemo
//
//  Created by 杨晴贺 on 9/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "CellFrameModel.h"
#import "CellModel.h"
#import "DynamicCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cellFrames ;

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动态Cell" ;
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadCell:) name:DynamicCellNotice object:nil] ;
}

// 刷新cell
- (void)reloadCell:(NSNotification *)info{
    NSDictionary *dic = info.userInfo ;
    NSString *picHeight = [[dic objectForKey:@"Height"] stringValue]  ;
    NSString *picWidth = [[dic objectForKey:@"Width"] stringValue] ;
    NSIndexPath *indexPath = [dic objectForKey:@"indexPath"] ;
    if (self.cellFrames.count >= indexPath.row) {
        CellFrameModel *frameModel = [self.cellFrames objectAtIndex:indexPath.row] ;
        frameModel.cellModel.picHeight = picHeight ;
        frameModel.cellModel.picWidth = picWidth ;
        // 重新生成模型对象
        frameModel.cellModel = frameModel.cellModel ;
        [self.cellFrames replaceObjectAtIndex:indexPath.row withObject:frameModel];
        // 刷新对应的cell
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
    }
}

#pragma mark - 实现数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellFrames.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell" ;
    DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID] ;
    if (cell == nil) {
        cell = [[DynamicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID] ;
    }
    for(UIView *subView in cell.contentView.subviews){
        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *tempImageView= (UIImageView *)subView;
            tempImageView.image=nil;
        }
        
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *tempLabel = (UILabel *)subView ;
            tempLabel.text = nil ;
        }
    }
    [cell showCellWithModel:self.cellFrames[indexPath.row] indexPath:indexPath] ;
    
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellFrameModel *cellFrame = self.cellFrames[indexPath.row] ;
    return cellFrame.cellHeight ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO] ;
}

#pragma mark - Lazy Load
- (NSMutableArray *)cellFrames{
    if(_cellFrames == nil){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"statuses.plist" ofType:nil] ;
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path] ;
        NSMutableArray *cellFrameArray = [NSMutableArray array] ;
        for(NSDictionary *dic in dicArray){
            CellModel *cellModel = [CellModel modelWithDic:dic] ;
            CellFrameModel *frameModel = [[CellFrameModel alloc]init] ;
            frameModel.cellModel = cellModel ;
            [cellFrameArray addObject:frameModel] ;
        }
        _cellFrames = cellFrameArray ;
    }
    return _cellFrames ;
}
@end
