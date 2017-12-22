//
//  ViewController.m
//  AuthorizationDemo
//
//  Created by Silence on 2017/12/22.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "SIAuthorizationManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = YES;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"打开相册权限",
                        @"打开相机权限",
                        @"打开媒体资料库权限",
                        @"打开麦克风权限",
                        @"打开位置权限",
                        @"打开蓝牙权限",
                        @"打开推送权限",
                        @"打开语音识别权限",
                        @"打开日历权限",
                        @"打开通讯录权限",
                        @"打开提醒事项权限",
                        @"打开运动与健身权限"];
    }
    return _titleArray;
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.textAlignment = 0;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypePhoto completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 1:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypeCamera completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 2:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypeMedia completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 3:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypeMicrophone completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 4:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypeLocation completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 5:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypeBluetooth completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 6:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypePushNotification completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 7:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypeSpeech completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 8:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypeEvent completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 9:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypeContact completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 10:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypeReminder completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 11:{
            [[SIAuthorizationManager sharedManager]requestAuthorizationType:SIAuthorizationTypeHealth completion:^(BOOL response, SIAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        default:
            break;
    }
    [tableView reloadData];
}



@end
