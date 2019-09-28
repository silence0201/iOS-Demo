//
//  ViewController.m
//  Bonjour
//
//  Created by Silence on 2019/9/28.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"

static NSString *kDomia = @"local.";
static NSString *kServiceType = @"_SclHttpService._tcp.";
static NSString *kServiceName = @"myBonjourServer";
static int kServicePort = 10123;

@interface ViewController ()<NSNetServiceDelegate>
@property (nonatomic, strong) NSNetService *netService;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startPublish];
}

- (NSNetService *)netService {
    if (!_netService) {
        _netService = [[NSNetService alloc] initWithDomain:kDomia type:kServiceType name:kServiceName port:kServicePort];
        _netService.delegate = self;
    }
    return _netService;
}

- (void)startPublish {
    [self.netService scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.netService publish];
}

- (NSData *)textRecordData {
    NSData *data = [@"Hello,World" dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *txtRecordDictionary = @{@"user" : data};
    return [NSNetService dataFromTXTRecordDictionary:txtRecordDictionary];
}

#pragma mark -- NetServiceDelegate
- (void)netServiceWillPublish:(NSNetService *)sender {
    NSLog(@"Service  Will Publish");
}

- (void)netServiceDidPublish:(NSNetService *)sender {
    NSLog(@"Service  Did Publish");
    [self.netService setTXTRecordData:[self textRecordData]];
}

- (void)netService:(NSNetService *)sender didNotPublish:(NSDictionary<NSString *,NSNumber *> *)errorDict {
    NSLog(@"Service didNot Publish ");
}


@end
