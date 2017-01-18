//
//  SIMovieGuide.h
//  MovieGuideDemo
//
//  Created by 杨晴贺 on 18/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SIMovieGuide ;
typedef void(^EnterBlock)(SIMovieGuide *guide) ;
@interface SIMovieGuide : UIViewController

@property (nonatomic,strong) NSURL *movieURL ;

@property (nonatomic,copy) EnterBlock enterBlock ;

@end
