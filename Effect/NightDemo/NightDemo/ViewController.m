//
//  ViewController.m
//  NightDemo
//
//  Created by 杨晴贺 on 12/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "DKNightVersion.h"
#import "TableViewCell.h"
#import "PresentViewController.h"

// 添加自定义pickColor
@pickerify(TableViewCell, cellTintColor)


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.view addSubview:self.tableView] ;
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    navigationLabel.text = @"黑夜模式";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navigationLabel;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Present" style:UIBarButtonItemStylePlain target:self action:@selector(present)];
    self.navigationItem.leftBarButtonItem = item;
    
    UIBarButtonItem *normalItem = [[UIBarButtonItem alloc] initWithTitle:@"Normal" style:UIBarButtonItemStylePlain target:self action:@selector(normal)];
    normalItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    UIBarButtonItem *nightItem = [[UIBarButtonItem alloc] initWithTitle:@"Night" style:UIBarButtonItemStylePlain target:self action:@selector(night)];
    nightItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    UIBarButtonItem *redItem = [[UIBarButtonItem alloc] initWithTitle:@"Red" style:UIBarButtonItemStylePlain target:self action:@selector(red)];
    redItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    
    self.navigationItem.rightBarButtonItems = @[normalItem, nightItem, redItem];
    
    //    self.tableView.dk_backgroundColorPicker =  DKColorPickerWithKey(BG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
    self.navigationItem.leftBarButtonItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
}

- (void)night {
    self.dk_manager.themeVersion = DKThemeVersionNight;
}

- (void)normal {
    self.dk_manager.themeVersion = DKThemeVersionNormal;
}

- (void)red {
    self.dk_manager.themeVersion = @"RED";
}

-(void)present{
    [self presentViewController:[PresentViewController new] animated:YES completion:nil] ;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
        _tableView.delegate = self ;
        _tableView.dataSource  = self ;
        [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"Cell"] ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    }
    return _tableView ;
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.dk_cellTintColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
