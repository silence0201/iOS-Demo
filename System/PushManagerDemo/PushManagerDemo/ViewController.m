//
//  ViewController.m
//  PushManagerDemo
//
//  Created by Silence on 2017/12/24.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SIPushNotificationManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UNUserNotificationCenterDelegate>{
    UITableView *_tableView;
    NSArray *titleArray;
    
    CLLocationManager *_locationManager;
    double lon;
    double lat;
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    self.title = @"PushDemo";
    titleArray = @[@"普通推送",
                   @"普通推送,自定义提示音",
                   @"图像推送",
                   @"图像推送,自定义提示音",
                   @"图像推送,下载方式",
                   @"图像推送,下载方式,自定义提示音",
                   @"视频推送",
                   @"视频推送,自定义提示音",
                   @"视频推送,下载方式",
                   @"视频推送,下载方式,自定义提示音",
                   @"定时推送",
                   @"定时推送,自定义提示音",
                   @"指定时间",
                   @"指定时间,自定义提示音",
                   @"定时推送,字典方式",
                   @"定时推送,字典方式,自定义提示音",
                   @"交互推送",
                   @"交互推送,自定义提示音",
                   @"定点推送",
                   @"定点推送,自定义提示音"];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = YES;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 4;
    }else if (section == 2){
        return 4;
    }else if (section == 3){
        return 6;
    }else if (section == 4){
        return 2;
    }else if (section == 5){
        return 2;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor grayColor];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"普通类型";
    }else if (section == 1){
        return @"图像类型";
    }else if (section == 2){
        return @"视频类型";
    }else if (section == 3){
        return @"定时类型";
    }else if (section == 4){
        return @"交互类型";
    }else if (section == 5){
        return @"定点类型";
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[titleArray subarrayWithRange:NSMakeRange(0, 2)][indexPath.row]];
    }else if (indexPath.section == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[titleArray subarrayWithRange:NSMakeRange(2, 4)][indexPath.row]];
    }else if (indexPath.section == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[titleArray subarrayWithRange:NSMakeRange(6, 4)][indexPath.row]];
    }else if (indexPath.section == 3){
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[titleArray subarrayWithRange:NSMakeRange(10, 6)][indexPath.row]];
    }else if (indexPath.section == 4){
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[titleArray subarrayWithRange:NSMakeRange(16, 2)][indexPath.row]];
    }else if (indexPath.section == 5){
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[titleArray subarrayWithRange:NSMakeRange(18, 2)][indexPath.row]];
    }
    cell.textLabel.textAlignment = 0;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{ // "普通类型" = "PushNotificationStyleNormal";
            if (indexPath.row == 0) {
                [[SIPushNotificationManager sharedInstance]normalPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"1-1" timeInterval:3 userInfo:nil repeat:NO];   //`repeat` if you pick the repeat property 'YES',you require to set the timeInterval value >= 60second ->是否重复,若要重复->时间间隔应>=60s
            }else if (indexPath.row == 1){
                [[SIPushNotificationManager sharedInstance]normalPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"1-2" soundName:@"tmp.mp3" timeInterval:3 userInfo:nil repeat:NO];
            }
        }break;
            
        case 1:{ //"图像类型" = "PushNotificationStyleGraphics";
            if (indexPath.row == 0) {
                [[SIPushNotificationManager sharedInstance]graphicsPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"2-1" fileName:@"Graphics.jpg" timeInterval:3 userInfo:nil repeat:NO];
            }else if (indexPath.row == 1){
                [[SIPushNotificationManager sharedInstance]graphicsPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"2-2" fileName:@"Graphics.jpg" soundName:@"tmp.mp3" timeInterval:3 userInfo:nil repeat:NO];
            }else if (indexPath.row == 2){
                [[SIPushNotificationManager sharedInstance]graphicsPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"2-3" urlString:@"https://i.loli.net/2017/09/30/59cf8056a1e21.jpg" timeInterval:3 userInfo:nil repeat:NO];
            }else if (indexPath.row == 3){
                [[SIPushNotificationManager sharedInstance]graphicsPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"2-4" urlString:@"https://i.loli.net/2017/09/30/59cf8056a1e21.jpg" soundName:@"tmp.mp3" timeInterval:3 userInfo:nil repeat:NO];
            }
        }break;
            
        case 2:{ // "视频类型" = "PushNotificationStyleVideo";
            if (indexPath.row == 0) {
                [[SIPushNotificationManager sharedInstance]videoPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"3-1" fileName:@"Raining.mp4" timeInterval:3 userInfo:nil repeat:NO];
            }else if (indexPath.row == 1){
                [[SIPushNotificationManager sharedInstance]videoPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"3-2" fileName:@"Raining.mp4" soundName:@"tmp.mp3" timeInterval:3 userInfo:nil repeat:NO];
            }else if (indexPath.row == 2){
                [[SIPushNotificationManager sharedInstance]videoPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"3-3" urlString:@"http://mvideo.spriteapp.cn/video/2017/0929/043c1392-a527-11e7-8f71-1866daeb0df1cutblack_wpcco.mp4" timeInterval:5  userInfo:nil repeat:NO];
            }else if (indexPath.row == 3){
                [[SIPushNotificationManager sharedInstance]videoPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"3-4" urlString:@"http://mvideo.spriteapp.cn/video/2017/0929/043c1392-a527-11e7-8f71-1866daeb0df1cutblack_wpcco.mp4" soundName:@"tmp.mp3" timeInterval:5 userInfo:nil repeat:NO];
            }
        }break;
            
        case 3:{ // "定时类型" = "PushNotificationStyleTiming";
            if (indexPath.row == 0) {
                [[SIPushNotificationManager sharedInstance]timingPushNotificationWithTitle:@"2017-10-1" subTitle:@"Happy National Day" body:@"World Peace Hooray!" identifier:@"4-1" weekday:@"1" hour:@"2" minute:@"49" second:@"50" userInfo:nil repeat:NO];
            }else if (indexPath.row == 1){
                [[SIPushNotificationManager sharedInstance]timingPushNotificationWithTitle:@"2017-10-1" subTitle:@"Happy National Day" body:@"World Peace Hooray!" identifier:@"4-2" weekday:@"1" hour:@"2" minute:@"49" second:@"50" soundName:@"tmp.mp3"  userInfo:nil repeat:NO];  // 星期一2:49:50 ->Tuesday 2:33:10
            }else if (indexPath.row == 2){
                [[SIPushNotificationManager sharedInstance]timingPushNotificationWithTitle:@"王菲" subTitle:@"《单行道》" body:@"春眠不觉晓,庸人偏自扰" identifier:@"4-3" year:@"2017" month:@"10" day:@"2" hour:@"2" minute:@"51" second:@"40"  userInfo:nil repeat:NO]; //2017-10-2 2:51:40
            }else if (indexPath.row == 3){
                [[SIPushNotificationManager sharedInstance]timingPushNotificationWithTitle:@"王菲" subTitle:@"《单行道》" body:@"春眠不觉晓,庸人偏自扰" identifier:@"4-4" year:@"2017" month:@"10" day:@"11" hour:@"12" minute:@"0" second:nil soundName:@"tmp.mp3"  userInfo:nil repeat:NO];
            }else if (indexPath.row == 4){
                [[SIPushNotificationManager sharedInstance]timingPushNotificationWithTitle:@"Bang Gang" subTitle:@"《Forever Now》" body:@"You can see her in the distance\n Where she walks alone\n Thenyou follow her direction\n To your second home" identifier:@"4-5" fireDate:@{@"year":@2017,@"month":@10,@"day":@2,@"hour":@2,@"minute":@55}  userInfo:nil repeat:NO];
            }else if (indexPath.row == 5){
                [[SIPushNotificationManager sharedInstance]timingPushNotificationWithTitle:@"Bang Gang" subTitle:@"《Forever Now》" body:@"You can see her in the distance\n Where she walks alone\n Thenyou follow her direction\n To your second home" identifier:@"4-6" fireDate:@{@"year":@2017,@"month":@10,@"weekday":@1,@"hour":@3,@"minute":@3} soundName:@"tmp.mp3"  userInfo:nil repeat:NO]; //2017-10 每周1 早上3点 -> 2017-10 every Monday 3:00 in China
            }
        }break;
            
        case 4:{ //"交互类型" = "PushNotificationStyleInteractive";
            if (indexPath.row == 0) {
                /////////
                UNTextInputNotificationAction *action1 = [UNTextInputNotificationAction actionWithIdentifier:@"reply" title:@"评论" options:UNNotificationActionOptionNone textInputButtonTitle:@"发送" textInputPlaceholder:@"说点什么"]; //reply action
                UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"enter" title:@"进入" options:UNNotificationActionOptionForeground]; //enter action
                UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:@"cancel" title:@"销毁" options:UNNotificationActionOptionDestructive]; //cancel action
                //;
                [[SIPushNotificationManager sharedInstance]interactivePushNotificationWithTitle:@"Bang Gang" subTitle:@"《Forever Now》" body:@"You can see her in the distance\n Where she walks alone\n Then you follow her direction\n To your second home" identifier:@"5-1" identifierArray:@[@"reply",@"enter",@"cancel"] actionArray:@[action1,action2,action3] timeInterval:3  userInfo:nil repeat:NO];
            }else if (indexPath.row == 1){
                /////////
                UNTextInputNotificationAction *action1 = [UNTextInputNotificationAction actionWithIdentifier:@"reply" title:@"评论" options:UNNotificationActionOptionNone textInputButtonTitle:@"发送" textInputPlaceholder:@"说点什么"]; //reply action
                UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"enter" title:@"进入" options:UNNotificationActionOptionForeground]; //enter action
                UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:@"cancel" title:@"销毁" options:UNNotificationActionOptionDestructive]; //cancel action
                //;
                [[SIPushNotificationManager sharedInstance]interactivePushNotificationWithTitle:@"Bang Gang" subTitle:@"《Forever Now》" body:@"You can see her in the distance\n Where she walks alone\n Then you follow her direction\n To your second home" identifier:@"5-2" identifierArray:@[@"reply",@"enter",@"cancel"] actionArray:@[action1,action2,action3] soundName:@"tmp.mp3" timeInterval:3 userInfo:nil repeat:NO];
            }
        }break;
            
        case 5:{ // "定点类型" = "PushNotificationStyleLocation";
            if (indexPath.row == 0) {
                [[SIPushNotificationManager sharedInstance]locationPushNotificationWithTitle:@"Pink Floyd" subTitle:@"《Wish You Were Here》" body:@"How I wish you were here" identifier:@"6-1" longitude:120.030632 latitude:30.288121 radius:100 notifyOnEntry:YES notifyOnExit:YES userInfo:nil repeat:NO];
            }else if (indexPath.row == 1){
                [[SIPushNotificationManager sharedInstance]locationPushNotificationWithTitle:@"Pink Floyd" subTitle:@"《Wish You Were Here》" body:@"How I wish you were here" identifier:@"6-2" longitude:120.030632 latitude:30.288121 radius:1000 notifyOnEntry:YES ontifyOnExit:YES soundName:@"tmp.mp3" userInfo:nil repeat:NO];
            }
        }break;
            
        default:
            break;
    }
    [tableView reloadData];
}


#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error:you need open the permission of location");
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks[0];
            if (!placemark.location) {
                NSLog(@"Unable to locate the current city");
            }
            lon = coordinate.longitude;
            lat = coordinate.latitude;
        }else if (error == nil && placemarks.count == 0){
            NSLog(@"No location and error return");
        }else if (error){
            NSLog(@"location error: %@",error);
        }
    }];
    [_locationManager stopUpdatingHeading];
}
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"enter the region");
}
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"leave the region");
}

#pragma mark - `Receives the push notification in the foreground`->`前台收到推送`
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}
#pragma mark 应用在后台收到推送的处理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    completionHandler();
}



@end
