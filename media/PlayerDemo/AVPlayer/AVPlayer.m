//
//  AVPlayer.m
//  PlayerDemo
//
//  Created by 杨晴贺 on 2017/3/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "AVPlayer.h"
#import "Extension.h"
#import "AppDelegate.h"

typedef NS_ENUM(NSInteger,PanDirection){
    PanDirectionHorizontalMoved,
    PanDirectionVerticalMoved
};

@interface APlayer ()

@property (nonatomic,strong) NSString *url ;  // URL

@property (nonatomic,strong) AVPlayer *player ;  // 播放器对象
@property (nonatomic,strong) UIView *container ;  // 播放器容器
@property (nonatomic,strong) AVPlayerItem *playerItem ;  // 播放对象

@property (nonatomic,strong) UIButton *playerButton ;  // 播放暂停按钮
@property (nonatomic,strong) UILabel *startTime ;  // 当前播放时间
@property (nonatomic,strong) UILabel *endTime ; // 总时间
@property (nonatomic,strong) UISlider *progress ;  // 播放进度条
@property (nonatomic,strong) UISlider *playableProgress ;  // 加载进度条
@property (nonatomic,strong) UISlider *value ;  // 音量
@property (nonatomic,strong) UIButton *backButton ;  // 返回按钮
@property (nonatomic,strong) UIView *backView ; // 返回背景
@property (nonatomic,strong) UIImageView *timeImage ; // 进度调图片
@property (nonatomic,strong) UILabel *timeLabel ; // 进度条拖动时间label
@property (nonatomic,strong) UISlider *systemVolume ; // 系统音量
@property (nonatomic,assign) BOOL isSliding ; // 进度条是否被拖动
@property (nonatomic,strong) UIActivityIndicatorView *activity ; // 等待小菊花
@property (nonatomic,assign) BOOL isTouched ; // 暂停状态是由使用者手动触发的还是网络加载不畅出发的

@property (nonatomic,assign) PanDirection direction ;  // 方向

@end

@implementation APlayer

#pragma mark --- init
- (instancetype)initWithURL:(NSString *)url{
    if (self = [super init]) {
        _url = url ;
    }
    return self ;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
    [self.playerItem removeObserver:self forKeyPath:@"status"] ;
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"] ;
}

#pragma mark --- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor] ;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    // 初始化播放器
    [self initPlayer] ;
    // 初始化UI界面
    [self setupUI] ;
    // 添加触控事件
    [self addGesture] ;
    // 添加通知
    [self addNotification] ;
    
}

// 初始化播放器
- (void)initPlayer{
    if(!_player){
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_url]] ;
        _player = [AVPlayer playerWithPlayerItem:self.playerItem] ;
        [self addProgressObserver] ;
        [self addObserverToPlayerItem] ;
    }
}

// 设置UI
- (void)setupUI{
    // Container
    self.container = [[UIView alloc]init] ;
    self.container.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) ;
    [self.view addSubview:self.container] ;
    
    // 创建播放器层
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player] ;
    playerLayer.frame = self.container.frame ;
    [self.container.layer addSublayer:playerLayer] ;
    
    // Back View
    self.backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    self.backView.backgroundColor = [UIColor clearColor] ;
    self.view.userInteractionEnabled = YES ;
    self.backView.userInteractionEnabled = YES ;
    [self.view addSubview:self.backView] ;
    
    // Play Button
    self.playerButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [self.playerButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal] ;
    [self.playerButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateSelected] ;
    self.playerButton.frame = CGRectMake(0, 0, 46, 46) ;
    self.playerButton.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2); ;
    self.playerButton.userInteractionEnabled = NO ;
    [self.backView addSubview:self.playerButton] ;
    
    // Start Time
    self.startTime = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 -35 -10 -30, SCREEN_HEIGHT - 45, 35, 15)] ;
    self.startTime.text = @"00:00" ;
    self.startTime.font = [UIFont systemFontOfSize:12] ;
    self.startTime.textColor = [UIColor whiteColor] ;
    [self.backView addSubview:self.startTime] ;
    
    // 间隔
    UILabel *spea = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 35 - 3, SCREEN_HEIGHT - 46, 10, 15)] ;
    spea.text = @"/" ;
    spea.font = [UIFont systemFontOfSize:12] ;
    spea.textColor = [UIColor whiteColor] ;
    [self.backView addSubview:spea] ;
    
    // end time
    self.endTime = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 30, SCREEN_HEIGHT - 45, 35, 15)] ;
    self.endTime.text = @"00:00" ;
    self.endTime.font = [UIFont systemFontOfSize:12] ;
    self.endTime.textColor = [UIColor whiteColor] ;
    [self.backView addSubview:self.endTime] ;

    // 加载进度条
    self.playableProgress = [[UISlider alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 15 -15 , SCREEN_WIDTH, 15)] ;
    self.playableProgress.minimumTrackTintColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    self.playableProgress.maximumTrackTintColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:0.5];
    UIImage *thumbImageEmp = [[UIImage alloc]init];
    [self.playableProgress setThumbImage:thumbImageEmp forState:UIControlStateNormal];
    [self.playableProgress setThumbImage:thumbImageEmp forState:UIControlStateSelected];
    self.playableProgress.userInteractionEnabled = NO;
    [self.view addSubview:self.playableProgress];
    
    // 播放进度
    self.progress = [[UISlider alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 15 -15 , SCREEN_WIDTH, 15)] ;
    self.progress.minimumTrackTintColor = [UIColor whiteColor];
    self.progress.maximumTrackTintColor = [UIColor clearColor];
    UIImage *thumbImage0 = [UIImage imageNamed:@"Oval 1"];
    [self.progress setThumbImage:thumbImage0 forState:UIControlStateNormal];
    [self.progress setThumbImage:thumbImage0 forState:UIControlStateSelected];
    [self.progress addTarget:self action:@selector(valueChange:event:) forControlEvents:UIControlEventValueChanged];
    [self.progress addTapGestureWithTarget:self action:@selector(resetSlider)];
    [self.view addSubview:self.progress];
    
    // 返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"Safari Back"] forState:UIControlStateNormal];
    self.backButton.frame = CGRectMake(15, 15, 34, 34);
    [self.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.backButton];
    
    //  timeImage
    self.timeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ThumBut"]];
    self.timeImage.frame = CGRectMake(0, 0, 30, 12);
    self.timeImage.hidden = YES;
    [self.view addSubview:self.timeImage];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 12)];
    self.timeLabel.font = [UIFont systemFontOfSize:8];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.timeImage addSubview:self.timeLabel];
    
    self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activity.frame = CGRectMake(0, 0, 30, 30);
    self.activity.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);;
    [self.view addSubview:self.activity];
}

- (void)addGesture{
    // 点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playClick)] ;
    [self.view addGestureRecognizer:tap] ;
    
    // 滑动时间
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)] ;
    [self.view addGestureRecognizer:pan] ;
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem] ;
}


#pragma mark --- Action
// 给播放器添加进度更新
- (void)addProgressObserver{
    AVPlayerItem *playerItem = self.player.currentItem ;
    // 这里设置每秒执行一次
    __weak typeof(self) weakSelf = self ;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time) ;
        float total = CMTimeGetSeconds([playerItem duration]) ;
        if(current){
            if(!weakSelf.isSliding){
                weakSelf.progress.value = current / total ;
            }
            weakSelf.startTime.text = [weakSelf currentTimeToString:current] ;
        }
    }] ;
}

// 给AVPlayerItem添加监听
- (void)addObserverToPlayerItem{
    // 监控状态属性
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil] ;
    // 监控网络加载情况属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil] ;
}

- (void)valueChange:(UISlider *)progress event:(UIEvent *)event{
    UITouch *touch = [event allTouches].anyObject ;
    NSTimeInterval static currenttime ;
    switch (touch.phase) {
        case UITouchPhaseBegan:
            self.isSliding = YES ;
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playButtonDisappear) object:nil];
            break;
        case UITouchPhaseMoved:
            currenttime = self.progress.value * CMTimeGetSeconds([self.playerItem duration]);
            self.startTime.text = self.startTime.text = [self currentTimeToString:currenttime];
            self.timeImage.hidden = NO;
            self.timeImage.center = CGPointMake((SCREEN_WIDTH - 12)* self.progress.value + 6, self.progress.frame.origin.y - 15);
            self.timeLabel.text = self.startTime.text;
            break ;
        case UITouchPhaseEnded:
            self.isSliding = NO;
            [self performSelector:@selector(playButtonDisappear) withObject:nil afterDelay:3];
            self.timeImage.hidden = YES;
            [self resetSlider];
        default:
            break;
    }
}

- (void)resetSlider{
    CMTime dragedCMTime = CMTimeMake(self.progress.value * CMTimeGetSeconds([self.playerItem duration]), 1);
    [self.player pause];
    [self.player seekToTime:dragedCMTime completionHandler:^(BOOL finish){
        [self playClick];
    }];
}

- (void)backButtonAction{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate ;
    app.isRotation = NO ;
    [self.player pause];
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

- (void)playClick{
    //  播放状态->暂停
    if (self.player.rate==1) {
        self.isTouched = YES;
        [self.player pause];
        self.playerButton.selected = YES;
        [self playButtonAppear];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playButtonDisappear) object:nil];
        
    }else { //  暂停状态->播放
        self.isTouched = NO;
        self.playerButton.selected = NO;
        [self.player play];
        [UIView animateWithDuration:0.3 animations:^{
            self.playerButton.alpha = 0;
        }];
        [self performSelector:@selector(playButtonDisappear) withObject:nil afterDelay:3];
    }

}

- (void)panAction:(UIPanGestureRecognizer *)pan{
    //  滑动速率
    CGPoint velocityPoint = [pan velocityInView:pan.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            self.isSliding = YES;
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playButtonDisappear) object:nil];
            //  判断滑动方向
            if (fabs(velocityPoint.x) > fabs(velocityPoint.y)) {
                _direction = PanDirectionHorizontalMoved;
            }else {
                _direction = PanDirectionVerticalMoved;
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            switch (_direction) {
                case PanDirectionHorizontalMoved:{
                    //  水平移动
                    self.progress.value += velocityPoint.x / 100000;
                    self.timeImage.hidden = NO;
                    self.timeImage.center = CGPointMake((SCREEN_WIDTH - 12)* self.progress.value + 6, self.progress.frame.origin.y - 15);
                    self.timeLabel.text = self.startTime.text;
                }
                case PanDirectionVerticalMoved:{
                    //  垂直移动
                    self.player.volume -= velocityPoint.y / 10000;   //  播放器音量
                    self.systemVolume.value = self.player.volume;         //  系统音量
                }
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
            self.isSliding = NO;
            [self performSelector:@selector(playButtonDisappear) withObject:self afterDelay:3];
            switch (_direction) {
                case PanDirectionHorizontalMoved:{
                    //  水平移动 结束
                    [self resetSlider];
                    self.timeImage.hidden = YES;
                    break;
                }
                case PanDirectionVerticalMoved:{
                    //  垂直移动结束
                    break;
                }
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

- (void)playbackFinished:(NSNotification *)noti{
    NSLog(@"播放完成") ;
}

//  控件出现(动画)
- (void)playButtonAppear {
    //  slider
    [UIView animateWithDuration:0.2 animations:^{
        self.progress.y = SCREEN_HEIGHT -30;
        self.playableProgress.y = SCREEN_HEIGHT-30;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.hidden = NO;
        self.backView.alpha = 1;
        self.playerButton.alpha = 1;
    }];
}

//  控件消失(动画)
-(void)playButtonDisappear {
    if (self.playerButton.selected) {
        return;
    }
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.progress.y = SCREEN_HEIGHT -9;
        self.playableProgress.y = SCREEN_HEIGHT -9;
    } completion:nil];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        self.backView.hidden = YES;
    }];
}

#pragma mark --- KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem *playerItem = object ;
    if([keyPath isEqualToString:@"status"]){
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] intValue] ;
        if (status == AVPlayerStatusReadyToPlay) {
            [self playClick] ;
            self.endTime.text = [self currentTimeToString:CMTimeGetSeconds(playerItem.duration)] ;
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array = playerItem.loadedTimeRanges ;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        self.playableProgress.value = totalBuffer / 100 ;
        
        if (!_isTouched) {
            if (self.player.rate==0) {
                [_activity startAnimating] ;
            }else {
                [_activity stopAnimating] ;
            }
        }
    }
}

#pragma mark --- Private
- (NSString *)currentTimeToString:(NSTimeInterval)currentTime{
    NSInteger static min;
    NSInteger static second;
    min = currentTime / 60;
    second = currentTime - 60 * min;
    return [NSString stringWithFormat:@"%02ld:%02ld", min, second];
}

@end
