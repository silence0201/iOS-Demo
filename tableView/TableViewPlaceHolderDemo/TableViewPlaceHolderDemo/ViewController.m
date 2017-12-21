//
//  ViewController.m
//  TableViewPlaceHolderDemo
//
//  Created by Silence on 2017/12/21.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+Placeholder.h"

//弱引用
#define kWeak(self) @autoreleasepool{} __weak typeof(self) self##Weak = self;
//强引用
#define kStrong(self) @autoreleasepool{} __strong typeof(self##Weak) self = self##Weak;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *data;

@property (nonatomic, strong) UIView *customView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.customView = [[[NSBundle mainBundle] loadNibNamed:@"Custom" owner:self options:nil]lastObject];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    kWeak(self);
    self.tableView.placeholderText = @"这是一行提示的文字呀";
    self.tableView.placeholderImage = [UIImage imageNamed:@"TableViewNoData"];
    self.tableView.placeholderClickBlock = ^(UIView *view) {
        kStrong(self);
        NSLog(@"Click");
        self.data = @[@"删除数据，显示默认提示",@"删除数据，显示自定义提示"];
        [self.tableView reloadData];
    };
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            _data = @[];
            tableView.placeholderCustomView = nil;
            [tableView reloadData];
            break;
        case 1:
            _data = @[];
            tableView.placeholderCustomView = self.customView;
            [tableView reloadData];
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark --- customPlaceHolderView

- (IBAction)resetTableViewData {
    _data = @[@"删除数据，显示默认提示",@"删除数据，显示自定义提示"];
    [self.tableView reloadData];
}

#pragma mark --- Get/Set
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

@end
