//
//  SISystemSound.m
//  SISystemSoundDemo
//
//  Created by Silence on 2019/1/15.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SISystemSound.h"

// Notifications
NSString *const SISystemSoundsWillPlayNotification    = @"SISystemSoundsWillPlayNotification";
NSString *const SISystemSoundsDidPlayNotification    = @"SISystemSoundsDidPlayNotification";

NSString *const SISystemSoundWillPlayNotification    = @"SISystemSoundWillPlayNotification";
NSString *const SISystemSoundDidPlayNotification    = @"SISystemSoundDidPlayNotification";

NSString *const SISystemSoundKey                    = @"SISystemSoundKey";
NSString *const SISystemSoundContinuesKey            = @"SISystemSoundContinuesKey";

void SISystemSoundCompleted (SystemSoundID ssID, void* clientData);

@interface SISystemSound ()
- (void)_soundCompleted;
+ (SISystemSoundID)_scheduleTimer:(NSTimer*)timer;
+ (void)_soundWillPlay:(SISystemSound*)sound;
+ (void)_soundDidPlay:(SISystemSound*)sound;
@end

void SISystemSoundCompleted (SystemSoundID ssID, void* clientData){
    SISystemSound *sound = (SISystemSound *)CFBridgingRelease(clientData);
    if ([sound isKindOfClass:[SISystemSound class]])
        [sound _soundCompleted];
}

@implementation SISystemSound

- (id)initWithName:(NSString*)name{
    NSParameterAssert(name);
    NSString *soundPath = [[NSBundle mainBundle]
                           pathForResource:name
                           ofType:([[name pathExtension] length] ? nil : @"caf")];
    self = [self initWithPath:soundPath];
    return self;
}

- (id)initWithPath:(NSString*)path{
    NSParameterAssert(path);
    if ((self = [super init])){
        NSURL *URL = [NSURL fileURLWithPath:path];
        if ((AudioServicesCreateSystemSoundID((__bridge CFURLRef)URL, &_soundID)) != noErr){
            NSLog(@"could not load system sound: %@", path);
            return nil;
        }
    }
    return self;
}

+ (SISystemSound*)soundWithName:(NSString*)name {
    static NSMutableDictionary *sNamedSounds = nil;
    SISystemSound *sound = nil;
    @synchronized([SISystemSound class]){
        if (sNamedSounds == nil)
            sNamedSounds = [[NSMutableDictionary alloc] init];
        sound = [sNamedSounds objectForKey:name];
        if (!sound){
            sound = [[SISystemSound alloc] initWithName:name];
            [sNamedSounds setObject:sound forKey:name];
        }
    }
    return sound;
}

- (void)dealloc{
    AudioServicesDisposeSystemSoundID(_soundID);
}


- (void)play
{
    @synchronized(self){
        if (_playing == 0){
            AudioServicesAddSystemSoundCompletion(_soundID, NULL, NULL, SISystemSoundCompleted, CFBridgingRetain(self));
        }
        _playing++;
        
        [[self class] _soundWillPlay:self];
        AudioServicesPlaySystemSound(_soundID);
    }
}

static unsigned int sSoundsPlaying = 0;

+ (void)_soundWillPlay:(SISystemSound*)sound{
    @synchronized([SISystemSound class]){
        if (sSoundsPlaying == 0)
            [[NSNotificationCenter defaultCenter]
             postNotificationName:SISystemSoundsWillPlayNotification
             object:nil];
        sSoundsPlaying++;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:SISystemSoundWillPlayNotification
     object:sound];
}

+ (void)_soundDidPlay:(SISystemSound*)sound{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:SISystemSoundDidPlayNotification
     object:sound];
    
    @synchronized([SISystemSound class]){
        sSoundsPlaying--;
        if (sSoundsPlaying == 0)
            [[NSNotificationCenter defaultCenter]
             postNotificationName:SISystemSoundsDidPlayNotification
             object:nil];
    }
}

- (void)_soundCompleted{
    @synchronized(self){
        [[self class] _soundDidPlay:self];
        _playing--;
        if (_playing == 0){
            AudioServicesRemoveSystemSoundCompletion(_soundID);
        }
    }
}


- (SISystemSoundID)scheduleRepeatWithInterval:(NSTimeInterval)interval{
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval
                                             target:[self class]
                                           selector:@selector(_scheduledTimerFired:)
                                           userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                     self,
                                                     SISystemSoundKey,
                                                     [NSNumber numberWithBool:YES],
                                                     SISystemSoundContinuesKey,
                                                     nil]
                                            repeats:YES];
    return [[self class] _scheduleTimer:timer];
}

- (SISystemSoundID)schedulePlayInInterval:(NSTimeInterval)interval{
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval
                                             target:[self class]
                                           selector:@selector(_scheduledTimerFired:)
                                           userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                     self,
                                                     SISystemSoundKey,
                                                     [NSNumber numberWithBool:NO],
                                                     SISystemSoundContinuesKey,
                                                     nil]
                                            repeats:NO];
    return [[self class] _scheduleTimer:timer];
}

- (SISystemSoundID)schedulePlayAtDate:(NSDate*)date{
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:date
                                               interval:0
                                                 target:[self class]
                                               selector:@selector(_scheduledTimerFired:)
                                               userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                         self,
                                                         SISystemSoundKey,
                                                         [NSNumber numberWithBool:NO],
                                                         SISystemSoundContinuesKey,
                                                         nil]
                                                repeats:NO] ;
    return [[self class] _scheduleTimer:timer];
}

static NSMutableDictionary *sScheduledTimers = nil;
static SISystemSoundID sCurrentSystemSoundID = 0;

+ (SISystemSoundID)_scheduleTimer:(NSTimer*)timer
{
    SISystemSoundID soundID;
    
    @synchronized([SISystemSound class]){
        sCurrentSystemSoundID++;
        soundID = sCurrentSystemSoundID;
        
        if (sScheduledTimers == nil)
            sScheduledTimers = [[NSMutableDictionary alloc] init];
        [sScheduledTimers setObject:timer forKey:[NSNumber numberWithInteger:soundID]];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
    return soundID;
}

+ (SISystemSoundID)_scheduleSound:(SISystemSound*)sound interval:(NSTimeInterval)interval{
    SISystemSoundID soundID;
    
    @synchronized([SISystemSound class]){
        sCurrentSystemSoundID++;
        soundID = sCurrentSystemSoundID;
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:interval
                                                 target:self
                                               selector:@selector(_scheduledTimerFired:)
                                               userInfo:sound
                                                repeats:YES];
        
        if (sScheduledTimers == nil)
            sScheduledTimers = [[NSMutableDictionary alloc] init];
        [sScheduledTimers setObject:timer forKey:[NSNumber numberWithInteger:soundID]];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
    return soundID;
}

+ (void)_scheduledTimerFired:(NSTimer*)timer{
    SISystemSound *sound = [[timer userInfo] objectForKey:SISystemSoundKey];
    BOOL shouldContinue = [[[timer userInfo] objectForKey:SISystemSoundContinuesKey] boolValue];
    
    if (sound)
        [sound play];
    
    if (!shouldContinue){
        @synchronized([SISystemSound class]){
            if ([timer isValid]){
                [timer invalidate];
                NSString *key = [[sScheduledTimers allKeysForObject:timer] lastObject];
                if (key)
                    [self unscheduleSoundID:[key intValue]];
            }
        }
    }
}

+ (void)unscheduleSoundID:(SISystemSoundID)soundID{
    if (soundID == SISystemSoundInvalidID)
        return;
    @synchronized([SISystemSound class]){
        NSNumber *key = [NSNumber numberWithInteger:soundID];
        NSTimer *timer = [sScheduledTimers objectForKey:key];
        if (timer){
            [timer invalidate];
            [sScheduledTimers removeObjectForKey:key];
        }
    }
}

@end
