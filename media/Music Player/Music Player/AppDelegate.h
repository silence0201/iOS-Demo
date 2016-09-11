//
//  AppDelegate.h
//  Music Player
//
//  Created by 杨晴贺 on 8/4/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RemoteBlock)(UIEvent *event);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 * 一个回调远程事件的block
 */
@property(nonatomic,copy)RemoteBlock remoteBlock;

@end

