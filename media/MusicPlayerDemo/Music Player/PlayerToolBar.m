//
//  PlayerToolBar.m
//  Music Player
//
//  Created by 杨晴贺 on 8/4/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "PlayerToolBar.h"
#import "UIImage+Shape.h"

@interface PlayerToolBar()

@property (weak, nonatomic) IBOutlet UIImageView *singerIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
/**
 * 总时间标签
 */
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
/**
 * 当前播放时间
 */
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;

/**
 * 时间拖拉视图
 */
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;

/**
 * 音乐工具类
 */
@property(nonatomic,strong)MusicTool *mTool;

/**
 * 定时器
 */
@property(nonatomic,strong)CADisplayLink *link;

/**
 * 时间是否正在拖动
 */
@property(nonatomic,assign)BOOL sliding;

@end

@implementation PlayerToolBar
+(instancetype)toolBar{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlayerToolBar" owner:nil options:nil] lastObject];
}

#pragma mark　设置slider的图片
-(void)awakeFromNib{
    //设置拖动图片
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"playbar_slider_thumb"] forState:UIControlStateNormal];
    
    //启动定时器
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

-(CADisplayLink *)link{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    
    return _link;
}

-(MusicTool *)mTool{
    if (!_mTool) {
        _mTool = [MusicTool shareMusicTool];
    }
    
    return _mTool;
}

-(void)update{
    //更新slider时间
    if (_playing && !_sliding) {//不在拖放，并且音乐为播放状态
        self.timeSlider.value = self.mTool.player.currentTime;
        self.currentTimeLabel.text = [NSString getMinuteSecondWithSecond:self.timeSlider.value];
        
        //头像转动
        CGFloat angle = M_PI_4 / 60;
        self.singerIcon.transform = CGAffineTransformRotate(self.singerIcon.transform, angle);
    }
    
    
}
#pragma mark 显示歌曲数据
-(void)setPlayingMusic:(Music *)playingMusic{
    _playingMusic = playingMusic;
    //显示歌曲数据
    UIImage *singerImage = [UIImage circleImageWithImage:[UIImage imageNamed:playingMusic.singerIcon] borderWidth:1 borderColor:[UIColor whiteColor]];
    
    self.singerIcon.image = singerImage;
    self.nameLabel.text = playingMusic.name;
    self.singerLabel.text = playingMusic.singer;
    
    //初始化左边Label的总时间
    self.totalTimeLabel.text = [NSString getMinuteSecondWithSecond:[MusicTool shareMusicTool].player.duration];
    
    //初始化Slider的总时间
    self.timeSlider.maximumValue = self.mTool.player.duration;
    self.timeSlider.value = 0;
    
    //初始化右边Label的当前播放进度时间
    self.currentTimeLabel.text = @"00:00";
}



#pragma mark 播放按钮事件
- (IBAction)playBtnClick:(UIButton *)btn {
    _playing = !_playing;
    if (_playing) {//播放
        [btn setNormalBg:@"playbar_playbtn_nomal" highlightedBg:@"playbar_playbtn_click"];
        [self notifyDelegateWithBtnType:PlayerBtnTypePlay];
    }else{//暂停
        [btn setNormalBg:@"playbar_pausebtn_nomal" highlightedBg:@"playbar_pausebtn_click"];
        [self notifyDelegateWithBtnType:PlayerBtnTypePause];
    }
}

- (IBAction)previousBtnClick:(id)sender {
    //图片恢复原状
    self.singerIcon.transform = CGAffineTransformIdentity;
    [self notifyDelegateWithBtnType:PlayerBtnTypePrev];
}
- (IBAction)nextBtnClick:(id)sender {
    self.singerIcon.transform = CGAffineTransformIdentity;
    [self notifyDelegateWithBtnType:PlayerBtnTypeNext];
}
#pragma mark 通知代理，按钮的点击
-(void)notifyDelegateWithBtnType:(PlayerBtnType)btnType{
    if ([self.delegate respondsToSelector:@selector(playerToolBar:btnClickWithType:)]) {
        [self.delegate playerToolBar:self btnClickWithType:btnType];
    }
}

#pragma mark -监听slider的事件
#pragma mark -slider被按下
- (IBAction)sliderTouchDown:(id)sender {
    NSLog(@"%s",__func__);
    _sliding = YES;
    //如果音乐正在播放，应该暂停
    if (_playing) {
        [self.mTool pause];
    }
}

#pragma mark -slider的值改变
- (IBAction)sliderValueChage:(UISlider *)slider {
    NSLog(@"%s %lf",__func__, slider.value);
    //时时改变slider拖动的右边时间
    self.currentTimeLabel.text = [NSString getMinuteSecondWithSecond:slider.value];
}

#pragma mark -slider的结束拖动
- (IBAction)sliderEndTouch:(UISlider *)slider {
    NSLog(@"%s %lf",__func__, slider.value);
    //结束拖动后，设置播放器的当前时间
    self.mTool.player.currentTime = slider.value;
    _sliding = NO;
    //恢复播放
    if (_playing) {
        [self.mTool play];
    }
}

-(void)dealloc{
    //定时器要从主运行循环移除
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

@end
