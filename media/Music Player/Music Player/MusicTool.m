//
//  MusicTool.m
//  Music Player
//
//  Created by 杨晴贺 on 8/4/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MusicTool.h"

@implementation MusicTool

+ (instancetype)shareMusicTool{
    static MusicTool *instance = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MusicTool alloc]init] ;
    });
    
    return instance ;
}

-(void)prepareToPlayWithMusic:(Music *)music{
    //1.获取文件路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:music.filename withExtension:nil];
    
    //2.初始化新的播放器
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player prepareToPlay];
    
    //3.初始化锁屏的歌曲信息
    [self setupLockInfoWithMP3Info:music];
}



-(void)play{
    [self.player play];
}


-(void)pause{
    [self.player pause];
}

/**
 *  设置锁屏时歌曲信息
 */
-(void)setupLockInfoWithMP3Info:(Music *)music{
    NSLog(@"%s",__func__);
    //锁屏信息设置
    NSMutableDictionary *playingInfo = [NSMutableDictionary dictionary];
    
    //1.专辑名称
    playingInfo[MPMediaItemPropertyAlbumTitle] = @"中文十大金曲";
    
    //2.歌曲
    playingInfo[MPMediaItemPropertyTitle] = music.name;
    
    //3.歌手名称
    playingInfo[MPMediaItemPropertyTitle] = music.singer;
    
    //4.专辑图片
    if(music.icon){
        UIImage *artWorkImage = [UIImage imageNamed:music.icon];
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:artWorkImage];
        playingInfo[MPMediaItemPropertyArtwork] = artwork;
    }
    
    //5.锁屏音乐总时间
    playingInfo[MPMediaItemPropertyPlaybackDuration] = @(self.player.duration);
    
    //设置锁屏时的播放信息
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = playingInfo;
}

@end
