//
//  MusicTool.h
//  Music Player
//
//  Created by 杨晴贺 on 8/4/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Music.h"

@interface MusicTool : NSObject

@property(nonatomic,strong)AVAudioPlayer *player;//播放器

/**
 *  单例
 */
+(instancetype)shareMusicTool ;


/**
 * 播放一首新的音乐时，必须先调用此方法
 */
-(void)prepareToPlayWithMusic:(Music *)music;


/**
 * 播放音乐
 */
-(void)play;

/**
 * 暂停
 */
-(void)pause;

@end
