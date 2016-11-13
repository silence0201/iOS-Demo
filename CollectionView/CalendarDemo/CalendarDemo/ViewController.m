//
//  ViewController.m
//  CalendarDemo
//
//  Created by 杨晴贺 on 13/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "CalendarViewController.h"
#import "CalendarHomeViewController.h"

@interface ViewController (){
    CalendarHomeViewController *_chvc ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:YES] ;
    self.title = @"日历Demo" ;
}

- (IBAction)selectAction:(UIButton *)sender {
    if(!_chvc){
        _chvc = [[CalendarHomeViewController alloc]init] ;
        _chvc.calendartitle = @"日期选择" ;
        [_chvc setAirPlaneToDay:365 ToDateforString:nil] ;  // 初始化
    }
    
    // 设置回调
    _chvc.calendarblock = ^(CalendarDayModel *model){
        if(model.holiday){
            [sender setTitle:[NSString stringWithFormat:@"%@ %@ %@",[model toString],[model getWeek],model.holiday] forState:UIControlStateNormal];
        }else{
            [sender setTitle:[NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]] forState:UIControlStateNormal];
        }
    } ;
    
    [self.navigationController pushViewController:_chvc animated:YES] ;
}




@end
