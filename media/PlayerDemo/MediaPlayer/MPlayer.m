//
//  MPlayer.m
//  PlayerDemo
//
//  Created by 杨晴贺 on 2017/3/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "MPlayer.h"
#import "Extension.h"

@interface MPlayer()

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer ;

@property (nonatomic,strong) UIButton *playButton ;
@property (nonatomic,strong) UILabel *startTime ;
@property (nonatomic,strong) UILabel *endTime ;
@property (nonatomic,strong) UISlider *progress ;
@property (nonatomic,strong) UISlider *playableProgress ;
@property (nonatomic,strong) UIButton *backButton ;
@property (nonatomic,strong) UIView *backView ;
@property (nonatomic,strong) NSTimer *timer ;
@property (nonatomic,strong) UIImageView *timeImage ;
@property (nonatomic,strong) UILabel *timeLabel ;

@end

@implementation MPlayer

#pragma mark --- init

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)urlStr{
    if (self = [super initWithFrame:frame]) {
        NSURL *url = [NSURL URLWithString:urlStr] ;
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url] ;
        _moviePlayer.view.frame = frame ;
        // 设置播放器样式
        _moviePlayer.controlStyle = MPMovieControlStyleNone ;
        // 关闭播放器相应,避免抢走其他控件的触摸事件
        _moviePlayer.view.userInteractionEnabled = NO ;
        [_moviePlayer play] ;
        [self addSubview:_moviePlayer.view] ;
        
        // 布局控件
        [self createUI] ;
        // 添加通知
        [self addNotification] ;
        // 播放按钮小时
        [self performSelector:@selector(playButtonDisappear) withObject:self afterDelay:3] ;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)] ;
        [self addGestureRecognizer:tap] ;
    }
    
    return self ;
}

- (void)createUI{
    // BackView
    self.backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    self.backView.backgroundColor = [UIColor clearColor] ;
    self.userInteractionEnabled = YES ;
    [self addSubview:self.backView] ;
    
    // 播放按钮
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [self.playButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal] ;
    [self.playButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateSelected] ;
    self.playButton.frame = CGRectMake(0, 0, 46, 46) ;
    self.playButton.center = self.center ;
    [self.playButton addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside] ;
    [self.backView addSubview:self.playButton] ;
    
    // 开始时间
    self.startTime = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 -35 -10 - 30, SCREEN_HEIGHT -45, 35, 15)] ;
    self.startTime.text = @"00:00" ;
    self.startTime.font = [UIFont systemFontOfSize:12] ;
    self.startTime.textColor = [UIColor whiteColor] ;
    [self.backView addSubview:self.startTime] ;
    
    // 分割
    UILabel *divLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 -35 -3, SCREEN_HEIGHT - 46, 10, 15)] ;
    divLabel.text = @"/" ;
    divLabel.font = [UIFont systemFontOfSize:12] ;
    divLabel.textColor = [UIColor whiteColor] ;
    [self.backView addSubview:divLabel] ;
    
    // 结束时间
    self.endTime = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 35, SCREEN_HEIGHT - 45, 35, 16)] ;
    self.endTime.text = @"00:00" ;
    self.endTime.font = [UIFont systemFontOfSize:12] ;
    self.endTime.textColor = [UIColor whiteColor] ;
    [self.backView addSubview:self.endTime] ;
    
    // 播放
    self.playableProgress = [[UISlider alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT -15 - 15, SCREEN_WIDTH, 15)] ;
    //  滑块左侧颜色
    self.playableProgress.minimumTrackTintColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] ;
    //  滑块右侧颜色
    self.playableProgress.maximumTrackTintColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:0.5] ;
    UIImage *thumbImag = [[UIImage alloc] init] ;
    [self.playableProgress setThumbImage:thumbImag forState:UIControlStateNormal] ;
    [self.playableProgress setThumbImage:thumbImag forState:UIControlStateSelected] ;
    self.playableProgress.userInteractionEnabled = NO ;
    [self addSubview:self.playableProgress] ;
    
    // Slider
    self.progress = [[UISlider alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 15 -15, SCREEN_WIDTH, 15)] ;
    self.progress.minimumTrackTintColor = [UIColor whiteColor] ;
    self.progress.maximumTrackTintColor = [UIColor clearColor] ;
    UIImage *thumbImas = [UIImage imageNamed:@"Oval 1"] ;
    [self.progress setThumbImage:thumbImas forState:UIControlStateNormal] ;
    [self.progress setThumbImage:thumbImas forState:UIControlStateSelected] ;
    [self.progress addTarget:self action:@selector(valeChange:event:) forControlEvents:UIControlEventValueChanged] ;
    [self.progress addTapGestureWithTarget:self action:@selector(resetSlider)] ;
    [self addSubview:self.progress] ;
    
    // Back Button
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [self.backButton setImage:[UIImage imageNamed:@"Safari Back"] forState:UIControlStateNormal] ;
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside] ;
    self.backButton.frame = CGRectMake(15, 15, 34, 34) ;
    [self.backView addSubview:self.backButton] ;
    
    // timeImage
    self.timeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ThumBut"]] ;
    self.timeImage.frame = CGRectMake(0, 0, 30, 12) ;
    self.timeImage.hidden = YES ;
    [self addSubview:self.timeImage] ;
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 12)] ;
    self.timeLabel.font = [UIFont systemFontOfSize:8] ;
    self.timeLabel.textAlignment = NSTextAlignmentCenter ;
    [self.timeImage addSubview:self.timeLabel] ;
    
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(durationAvailable) name:MPMovieDurationAvailableNotification object:_moviePlayer] ;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaPlayerPlaybackFinished) name:MPMoviePlayerPlaybackDidFinishNotification object:_moviePlayer] ;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
}

#pragma mark --- Action
- (void)backAction{
    [self.moviePlayer pause] ;
    [self removeFromSuperview] ;
}

- (void)valeChange:(UISlider *)slider event:(UIEvent *)event{
    NSTimeInterval currentTime ;
    NSInteger min ;
    NSInteger second ;
    UITouch *touch = [event allTouches].anyObject ;
    switch (touch.phase) {
        case UITouchPhaseBegan:
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playButtonDisappear) object:nil] ;
            [self.timer invalidate] ;
            break;
        case UITouchPhaseMoved:
            currentTime = self.progress.value * self.moviePlayer.duration ;
            min = currentTime / 60 ;
            second = currentTime - 60 * min ;
            self.startTime.text = [NSString stringWithFormat:@"%02ld:%02ld",min,second] ;
            self.timeImage.hidden = NO ;
            self.timeImage.center = CGPointMake((SCREEN_WIDTH - 12)* self.progress.value + 6, self.progress.frame.origin.y - 15) ;
            self.timeLabel.text = self.startTime.text;
        case UITouchPhaseEnded:
            self.timeImage.hidden = YES;
            self.moviePlayer.currentPlaybackTime = self.progress.value * self.moviePlayer.duration;
            if (self.moviePlayer.currentPlaybackRate == 0) {
                [self tapAction];
            }
            [self performSelector:@selector(playButtonDisappear) withObject:self afterDelay:3];
            [self.timer fire];
        default:
            break;
    }
}

- (void)resetSlider{
    self.moviePlayer.currentPlaybackTime = self.progress.value * self.moviePlayer.duration ;
    [self tapAction] ;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playButtonDisappear) object:nil] ;
    [self performSelector:@selector(playableDuration) withObject:self afterDelay:3] ;
    
}

- (void)durationAvailable{
    NSInteger min = self.moviePlayer.duration / 60 ;
    NSInteger second = self.moviePlayer.duration  - 60 * min ;
    self.endTime.text = [NSString stringWithFormat:@"%02ld:%02ld",min,second] ;
    
    // 开启定时器进行更新
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshCurrentTime) userInfo:nil repeats:YES] ;
}

- (void)refreshCurrentTime{
    NSInteger min = self.moviePlayer.currentPlaybackTime / 60 ;
    NSInteger second = self.moviePlayer.currentPlaybackTime  - 60 * min ;
    self.startTime.text = [NSString stringWithFormat:@"%02ld:%02ld",min,second] ;
    self.progress.value = self.moviePlayer.currentPlaybackTime / self.moviePlayer.duration ;
    self.playableProgress.value = self.moviePlayer.playableDuration / self.moviePlayer.duration ;
}

- (void)mediaPlayerPlaybackFinished{
    NSLog(@"%s",__func__) ;
}

- (void)playButtonDisappear{
    if (self.playButton.selected)  return ;
    [UIView animateWithDuration:0.2 animations:^{
        self.progress.y = SCREEN_HEIGHT - 9 ;
        self.playableProgress.y = SCREEN_HEIGHT - 9 ;
    }] ;
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.alpha = 0 ;
    }completion:^(BOOL finished) {
        self.backView.hidden = YES ;
    }] ;
}

- (void)tapAction{
    if(self.backView.hidden){
        [UIView animateWithDuration:0.2 animations:^{
            self.progress.y = SCREEN_HEIGHT - 30 ;
            self.playableProgress.y = SCREEN_HEIGHT - 30 ;
        }] ;
        [UIView animateWithDuration:0.5 animations:^{
            self.backView.hidden = NO ;
            self.backView.alpha = 1 ;
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playButtonDisappear) object:nil];
        }] ;
    }else{
        [self performSelector:@selector(playButtonDisappear) withObject:self afterDelay:3] ;
    }
    
    if(self.playButton.selected){
        [self.moviePlayer play] ;
    }else{
        [self.moviePlayer pause] ;
    }
    
    self.playButton.selected = !self.playButton.selected ;
}


@end
