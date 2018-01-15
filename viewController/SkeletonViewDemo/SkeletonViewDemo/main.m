 //
//  main.m
//  SkeletonViewDemo
//
//  Created by Silence on 2018/1/3.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

// Remote Plugin patch start //

#ifdef DEBUG
#define REMOTE_PORT 31459
#include "/Applications/Injection.app/Contents/Resources/RemoteCapture.h"
#define REMOTEPLUGIN_SERVERIPS "192.168.3.48"
@implementation RemoteCapture(Startup)
+ (void)load {
    [self performSelectorInBackground:@selector(startCapture:) withObject:@REMOTEPLUGIN_SERVERIPS];
}
@end
#endif

// Remote Plugin patch end //
