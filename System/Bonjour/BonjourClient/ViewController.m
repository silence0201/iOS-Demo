//
//  ViewController.m
//  BonjourClient
//
//  Created by Silence on 2019/9/28.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"

static NSString *kDomia = @"local.";
static NSString *kServiceType = @"_SclHttpService._tcp.";

@interface ViewController ()<NSNetServiceBrowserDelegate,NSNetServiceDelegate>
@property (nonatomic, strong) NSNetServiceBrowser *serviceBrowser;
@property (nonatomic, strong) NSMutableArray *netServices;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self start];
}

- (NSNetServiceBrowser *)serviceBrowser {
    if (_serviceBrowser) {
        _serviceBrowser = [[NSNetServiceBrowser alloc] init];
        _serviceBrowser.delegate = self;
    }
    
    return _serviceBrowser;
}

- (void)start {
    [self.serviceBrowser searchForServicesOfType:kServiceType inDomain:kDomia];
}

- (void)stop {
    [self.serviceBrowser stop];
}

#pragma mark -- NSNetServiceBrowserDelegate
- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
    NSLog(@"didFindService");
    [self.netServices addObject:service];
    service.delegate = self;
    [service resolveWithTimeout:2];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing {
    NSLog(@"didRemoveService");
    [self.netServices removeObject:service];
}

#pragma mark -- NSNetServiceDelegate

- (void)netServiceDidResolveAddress:(NSNetService *)sender {
    NSLog(@"netServiceDidResolveAddress hostName %@ domain %@  port %ld name %@ ",sender.hostName,sender.domain,sender.port,sender.name);
}

- (void)netService:(NSNetService *)sender didUpdateTXTRecordData:(NSData *)data {
    NSDictionary *infoDic = [NSNetService dictionaryFromTXTRecordData:data];
    NSData *infoData = infoDic[@"user"];
    NSString *str = [[NSString alloc]initWithData:infoData encoding:NSUTF8StringEncoding];
    NSLog(@"didUpdateTXTRecordData %@",str);
}

@end
