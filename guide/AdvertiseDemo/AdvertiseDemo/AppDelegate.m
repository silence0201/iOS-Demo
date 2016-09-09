//
//  AppDelegate.m
//  AdvertiseDemo
//
//  Created by 杨晴贺 on 9/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AdvertiseView.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc] init]] ;
    
    [self.window makeKeyWindow] ;
    
    // 判断沙盒中是否存在广告图片,如果存在,直接显示
    NSString *filePath = [self getFilePathWithImageName:[User_Defaults valueForKey:adImageName]] ;

    // 无论沙盒有没有广告,都需要重新调用广告接口判断广告是否更新
    [self getAdvertisingImage] ;

    // 判断图片是否存在
    BOOL isExist = [self isFileExistWithFilePath:filePath] ;
    
    if(isExist){
        // 图片存在
        AdvertiseView *advertiseView = [[AdvertiseView alloc]initWithFrame:self.window.bounds] ;
        advertiseView.filePath = filePath ;
        advertiseView.showTime = 10 ;
        [advertiseView show] ;
    }
    return YES;
}

#pragma mark - Private Method
// 根绝图片名称拼接文件路径
- (NSString *)getFilePathWithImageName:(NSString *)imageName{
    if(imageName){
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        NSString *filePath = [cachePath stringByAppendingPathComponent:imageName] ;
        
        return filePath ;
    }
    return nil ;
}

// 判断文件是否存在
- (BOOL)isFileExistWithFilePath:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager] ;
    BOOL isDirectory = FALSE ;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory] ;
}

// 更新广告接口
- (void)getAdvertisingImage{
    // 模拟广告接口
    NSArray *imageArray = @[@"http://7xwbzi.com1.z0.glb.clouddn.com/2016090923646IMG_0041.jpg",
                            @"http://7xwbzi.com1.z0.glb.clouddn.com/201609091605222.jpg",
                            @"http://7xwbzi.com1.z0.glb.clouddn.com/2016090953533.jpg",
                            @"http://7xwbzi.com1.z0.glb.clouddn.com/201609099626244.jpg",
                            @"http://7xwbzi.com1.z0.glb.clouddn.com/201609099549255.png"] ;
    // 模拟随机更新
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    // 获取图片的名称
    NSArray *strArray = [imageUrl componentsSeparatedByString:@"/"] ;
    NSString *imageName = [strArray lastObject] ;
    
    // 拼接沙盘路径
    NSString *filePath = [self getFilePathWithImageName:imageName] ;
    
    BOOL isExist = [self isFileExistWithFilePath:filePath] ;
    if(!isExist){
        // 如果图片不存在,进行下载
        [self downloadAdImageWithUrl:imageUrl imageName:imageName] ;
    }
}

// 下载图片
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]] ;
        UIImage *image = [UIImage imageWithData:data] ;
        
        NSString *filePath = [self getFilePathWithImageName:imageName] ;
        if([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]){
            NSLog(@"保存成功") ;
            [self deleteOldImage] ;
            [User_Defaults setValue:imageName forKey:adImageName] ;
            [User_Defaults synchronize] ;
        }else{
            NSLog(@"保存失败") ;
        }
    }) ;
}

// 删除旧的图片
- (void)deleteOldImage{
    NSString *imageName = [User_Defaults valueForKey:adImageName] ;
    if(imageName){
        NSString *filePath = [self getFilePathWithImageName:imageName] ;
        NSFileManager *fileManager = [NSFileManager defaultManager] ;
        [fileManager removeItemAtPath:filePath error:nil] ;
    }
}



@end
