//
//  ViewController.m
//  LiveRoomDemo
//
//  Created by Silence on 2018/2/26.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#import "UIColor+Extension.h"
#import "NSAttributedString+Extension.h"
#import "ChatModel.h"
#import "ChatTableViewCell.h"
#import "EmitterView.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *nickArr ;
@property (nonatomic,strong) NSMutableArray *textArr ;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) EmitterView *emitterView;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

static const NSInteger maxCell = 7;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageEffectLightFromImage:[UIImage imageNamed:@"test"]]];
    backImage.frame = self.view.bounds;
    [self.view addSubview:backImage];
    [self setupTableView];
    [self setUpEmitterView];
    [self setUpDataSource];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 100, 200, SCREEN_HEIGHT - 100 - 60) style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundView = [[UIView alloc] init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.transform = CGAffineTransformMakeScale(1, -1);
    self.tableView = tableView;
    
}

- (void)setUpEmitterView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH-75, SCREEN_HEIGHT - 75, 40, 40);
    [btn setImage:[UIImage imageNamed:@"click"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(emitterClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    EmitterView *emitterVeiw = [[EmitterView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-75, SCREEN_HEIGHT - 60 - 400, 60, 400)];
    [self.view addSubview:emitterVeiw];
    self.emitterView = emitterVeiw;
}

- (void)emitterClicked:(UIButton *)sender{
    [self.emitterView sendUpEmitter];
}

- (NSMutableArray *)nickArr{
    if (!_nickArr) {
        _nickArr = [[NSMutableArray alloc] init];
    }
    return _nickArr;
}

- (NSMutableArray *)textArr{
    if (!_textArr) {
        _textArr = [[NSMutableArray alloc] init];
    }
    return _textArr;
}

- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        _dataSourceArr = [[NSMutableArray alloc]init];
    }
    return _dataSourceArr;
}

- (void)setUpDataSource
{
    for (NSInteger i = 0; i < 6; i++) {
        NSString *nick = [NSString stringWithFormat:@"用户%zd", i];
        NSMutableString *text = [[NSMutableString alloc] initWithString:@"哈"];
        for (NSInteger j = 0; j <= i; j++) {
            [text appendFormat:@"哈"];
        }
        [text appendFormat:@"%zd", i];
        [self.nickArr addObject:nick];
        [self.textArr addObject:text];
    }
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(sendMessage) userInfo:nil repeats:YES];
}

NSInteger number = 0;
- (void)sendMessage{
    NSString *nick = self.nickArr[arc4random() % 6];
    NSString *text = self.textArr[arc4random() % 6];
    ChatModel *model = [[ChatModel alloc] init];
    model.nickName = nick;
    model.chatText = text;
    [self.dataSourceArr insertObject:model atIndex:0];
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
    if (self.dataSourceArr.count > maxCell) {
        [self.dataSourceArr removeLastObject];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:self.dataSourceArr.count] withRowAnimation:UITableViewRowAnimationNone];
    }
    number ++;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatModel *model = self.dataSourceArr[indexPath.section];
    NSArray *colors = kCColorZuHe;
    UIColor *color = (UIColor *)colors[arc4random() % 10];
    
    ChatTableViewCell *cell = [ChatTableViewCell crateChatTableViewCellWithTable:tableView];
    ChatModel *chatModel = model;
    [cell setCellAttributTitle:[NSAttributedString attributedStringWithStr:chatModel.nickName anotherString:chatModel.chatText andColor:color]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f ;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}


@end
