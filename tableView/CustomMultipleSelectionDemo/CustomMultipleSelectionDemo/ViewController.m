//
//  ViewController.m
//  CustomMultipleSelectionDemo
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

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 用于保存选择的indexPath
@property (nonatomic,copy) NSMutableArray *indexPathForSelectedRows ;

@end

@implementation ViewController

#pragma mark - getter methods
- (NSMutableArray *)wines{
    if (_wines == nil) {
        _wines = [Wine mj_objectArrayWithFilename:@"wine.plist"] ;
    }
    return _wines ;
}

- (NSMutableArray *)indexPathForSelectedRows{
    if (_indexPathForSelectedRows == nil) {
        _indexPathForSelectedRows = [NSMutableArray array] ;
    }
    return _indexPathForSelectedRows ;
}

#pragma mark - view controller 生命周期
- (void)viewDidLoad{
    [super viewDidLoad] ;
    
    // 注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:WineCellNibName bundle:nil] forCellReuseIdentifier:WineCellIdentifier] ;
    
    // 定义cell的高度
    self.tableView.rowHeight = 80 ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wines.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WineCell *cell = [tableView dequeueReusableCellWithIdentifier:WineCellIdentifier] ;
    
    cell.wine = _wines[indexPath.row] ;
    
    return cell ;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
    Wine *wine = self.wines[indexPath.row] ;
    wine.checked = !wine.isChecked ;
    if(wine.isChecked){
        // 如果现在wine是选中的状态，则表示要删除，加入到indexPathForSelectedRows中
        [self.indexPathForSelectedRows addObject:indexPath] ;
    }else{
        // 如果现在wine是未选中状态，则从indexPathForSelectedRow中删除表示不被删除
        [self.indexPathForSelectedRows removeObject:indexPath] ;
    }
    
    // 刷新显示页面
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    
}


#pragma mark - Actions
- (IBAction)delAction:(id)sender {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSIndexPath *indexPath in self.indexPathForSelectedRows) {
        [tempArray addObject:self.wines[indexPath.row]];
    }
    [self.wines removeObjectsInArray:tempArray];
    
    [self.tableView deleteRowsAtIndexPaths:self.indexPathForSelectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 注意这里要将self.indexPathForSelectedRow中的元素移除，否则下次使用的时候上次点击的记录依旧存在会出现错误
    [self.indexPathForSelectedRows removeAllObjects];
}



@end
