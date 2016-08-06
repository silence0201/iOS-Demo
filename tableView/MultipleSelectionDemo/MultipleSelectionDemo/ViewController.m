//
//  ViewController.m
//  MultipleSelectionDemo
//
//  Created by 杨晴贺 on 8/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "Wine.h"
#import "WineCell.h"

static NSString * const WineCellIdentifier = @"WineCell";
static NSString * const WineCellNibName    = @"WineCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
// 编辑按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;
// 表格View
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

#pragma mark - ViewController的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:WineCellNibName bundle:nil] forCellReuseIdentifier:WineCellIdentifier] ;
    
    // 设置cell的高度
    self.tableView.rowHeight = 80 ;
    
    // 设置可以多选
    self.tableView.allowsMultipleSelectionDuringEditing = YES ;
    
    NSLog(@"%@",self.wines) ;
}

#pragma mark - wine初始化
- (NSMutableArray *)wines{
    if (!_wines) {
        _wines = [Wine mj_objectArrayWithFilename:@"wine.plist"] ;
    }
    return _wines ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.wines count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WineCell *cell = [tableView dequeueReusableCellWithIdentifier:WineCellIdentifier] ;
    
    cell.wine = self.wines[indexPath.row] ;
    
    return cell ;
}

#pragma mark - button action
- (IBAction)editAction:(UIBarButtonItem *)sender {
    if([sender.title isEqualToString:@"确认"]){
        // 指向删除操作
        // 获取选择的cell 的indexpath
        NSArray *indexPaths = [self.tableView indexPathsForSelectedRows] ;
        // 获取row
        NSMutableArray *rowArrays = [NSMutableArray array] ;
        for(NSIndexPath *indexPath in indexPaths){
            [rowArrays addObject:self.wines[indexPath.row]] ;
        }
        
        // 删除模型数据
        [self.wines removeObjectsInArray:rowArrays] ;
        
        // 刷新表格
        [self.tableView reloadData] ;
        
    }
    sender.title = self.tableView.isEditing?@"编辑":@"确认" ;
    [self.tableView setEditing:!self.tableView.isEditing] ;
    
}





@end
