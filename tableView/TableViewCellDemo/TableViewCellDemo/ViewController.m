//
//  ViewController.m
//  TableViewCellDemo
//
//  Created by Silence on 2018/10/23.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ViewController.h"

typedef BOOL(^RunLoopBlock)(void);

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSMutableArray *tasksArray;
@property(nonatomic,assign) NSInteger maxQueLength;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVar];
    [self setupSubviews];
    [self addObverRunloop];
}

//添加任务的方法
- (void)addTask:(RunLoopBlock)unit {
    [self.tasksArray addObject:unit];
    if (self.tasksArray.count >self.maxQueLength) {
        [self.tasksArray removeObjectAtIndex:0];
    }
}

static void Callback(CFRunLoopObserverRef observer,CFRunLoopActivity activity,void *info){
    //每次来到这里往数组里拿任务处理
    ViewController *vc = (__bridge ViewController*)info;
    if (vc.tasksArray.count == 0) {
        return;
    }
    
    BOOL result = NO;
    while (result == NO && vc.tasksArray.count) {
        //取出任务
        RunLoopBlock unit = vc.tasksArray.firstObject;
        //执行任务
        result = unit();
        //干掉完成的任务
        [vc.tasksArray removeObjectAtIndex:0];
    }
    NSLog(@"Runing");
}

- (void)addObverRunloop {
    //拿到当前的runloop 凡是corefoundation里面的ref 代表 指针
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个观察者
    static CFRunLoopObserverRef observer;
    //定义一个context
    CFRunLoopObserverContext context = {
        0,
        (__bridge void*)self,
        &CFRetain,
        &CFRelease,
        NULL
    };
    //创建一个观察者
    observer = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &Callback, &context);
    //添加观察者
    CFRunLoopAddObserver(runloop, observer, kCFRunLoopCommonModes);
    //释放观察者
    CFRelease(observer);
}

#pragma mark --初始化变量

- (void)initVar {
    _tasksArray = [NSMutableArray array];
    _maxQueLength = 1000;
}
#pragma mark --创建UI界面
- (void)setupSubviews{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark --TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"leftCellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [self addTask:^BOOL{
        cell.textLabel.backgroundColor = [UIColor cyanColor];
        cell.textLabel.text = [NSString stringWithFormat:@"我是第%lu行",indexPath.row];
        return YES;
    }];
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    cell.layer.transform = rotation;
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}


@end
