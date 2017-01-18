//
//  SIMovieGuide.m
//  MovieGuideDemo
//
//  Created by 杨晴贺 on 18/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "SIMovieGuide.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SIMovieGuide ()

@property (nonatomic,strong) MPMoviePlayerController *player ;

@end

@implementation SIMovieGuide

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup] ;
}

- (void)setup{
    self.player = [[MPMoviePlayerController alloc]initWithContentURL:_movieURL] ;
    [self.view addSubview:self.player.view] ;
    self.player.shouldAutoplay = YES ;
    [self.player setControlStyle:MPMovieControlStyleNone] ;
    self.player.repeatMode = MPMovieRepeatModeOne ;
    [self.player.view setFrame:self.view.frame] ;
    self.player.view.alpha = 0 ;
    [UIView animateWithDuration:3 animations:^{
        self.player.view.alpha = 1;
        [self.player prepareToPlay];
    }];
    
    [self setupLoginView] ;
}

- (void)setupLoginView{
    //进入按钮
    UIButton *enterMainButton = [[UIButton alloc] init];
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"进入应用" forState:UIControlStateNormal];
    enterMainButton.alpha = 0;
    [self.player.view addSubview:enterMainButton];
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [UIView animateWithDuration:3.0 animations:^{
        enterMainButton.alpha = 1.0;
    }];
}

- (void)enterMainAction:(UIButton *)btn {
    NSLog(@"进入应用");
    if(self.enterBlock){
        self.enterBlock(self) ;
    }
    
}

@end
