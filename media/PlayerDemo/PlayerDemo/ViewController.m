//
//  ViewController.m
//  PlayerDemo
//
//  Created by 杨晴贺 on 2017/3/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "MPlayer.h"
#import "AVPlayer.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

static NSString *url = @"http://baobab.wdjcdn.com/1455782903700jy.mp4" ;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)MPlayerAction:(id)sender {
    MPlayer *player = [[MPlayer alloc]initWithFrame:[UIScreen mainScreen].bounds URL:url] ;
    [self.view addSubview:player] ;
}

- (IBAction)AVplayerAction:(id)sender {
    APlayer *player = [[APlayer alloc]initWithURL:url] ;
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate ;
    app.isRotation = YES ;
    [self presentViewController:player animated:YES completion:nil];
}



@end
