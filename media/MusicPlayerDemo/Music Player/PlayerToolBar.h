//
//  PlayerToolBar.h
//  Music Player
//
//  Created by 杨晴贺 on 8/4/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Music.h"
#import "UIButton+MoreStyle.h"
#import "NSString+GetSecond.h"
#import "MusicTool.h"
@class PlayerToolBar ;

typedef enum {
    PlayerBtnTypeIcon,//头像
    PlayerBtnTypePlay,//播放
    PlayerBtnTypePause,//暂停
    PlayerBtnTypePrev,//上一首
    PlayerBtnTypeNext,//下一首
}PlayerBtnType;
@protocol PlayerToolBarDelegate <NSObject>

-(void)playerToolBar:(PlayerToolBar *)toolBar btnClickWithType:(PlayerBtnType)btnType;

@end

@interface PlayerToolBar : UIView

+(instancetype)toolBar;

/**
 * 播放按钮的状态，默认是停止播放
 */
@property(nonatomic,assign,readonly,getter=isPlaying)BOOL playing;

/**
 * 当前播放音乐
 */
@property(nonatomic,strong)Music *playingMusic;

/**
 * 按钮点击代理
 */
@property(nonatomic,weak)id<PlayerToolBarDelegate> delegate;

@end
