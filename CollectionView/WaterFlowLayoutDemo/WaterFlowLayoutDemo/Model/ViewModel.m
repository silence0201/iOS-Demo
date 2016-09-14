//
//  ViewModel.m
//  WaterFlowLayoutDemo
//
//  Created by 杨晴贺 on 9/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewModel.h"
#import "MJExtension.h"
#import "DataModel.h"

@implementation ViewModel

- (NSArray *)dataArray{
    if (!_data) {
        NSArray *plistOneArray = [DataModel objectArrayWithFilename:@"1.plist"];
        NSArray *plistTwoArray = [DataModel objectArrayWithFilename:@"2.plist"];
        NSArray *plistThreeArray = [DataModel objectArrayWithFilename:@"3.plist"];
        _data = @[plistOneArray,plistTwoArray,plistThreeArray] ;
    }
    return _data ;
}

- (NSArray *)nameArray{
    if(!_nameArray){
        _nameArray = @[@"1.plist", @"2.plist", @"3.plist"];
    }
    return _nameArray ;
}

@end
