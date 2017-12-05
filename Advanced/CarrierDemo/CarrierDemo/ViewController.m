//
//  ViewController.m
//  CarrierDemo
//
//  Created by Silence on 2017/12/5.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@>%@",[self currentRadioAccessTechnology],[self subscriberCellularProvider]);
}


-(NSString *)currentRadioAccessTechnology{
    CTTelephonyNetworkInfo *current = [[CTTelephonyNetworkInfo alloc] init];
    return current.currentRadioAccessTechnology;
}

-(NSMutableDictionary *)subscriberCellularProvider{
    NSMutableDictionary *arr = [[NSMutableDictionary alloc]init];
    CTTelephonyNetworkInfo *current = [[CTTelephonyNetworkInfo alloc] init];
    [arr setObject:current.subscriberCellularProvider.carrierName ?: @"" forKey:@"carrierName"];
    [arr setObject:current.subscriberCellularProvider.mobileCountryCode ?: @"" forKey:@"mobileCountryCode"];
    [arr setObject:current.subscriberCellularProvider.mobileNetworkCode ?: @"" forKey:@"mobileNetworkCode"];
    [arr setObject:current.subscriberCellularProvider.isoCountryCode ?: @"" forKey:@"isoCountryCode"];
    [arr setObject:[NSNumber numberWithBool:current.subscriberCellularProvider.allowsVOIP] ?: @(0) forKey:@"allowsVOIP"];
    return arr;
}

@end
