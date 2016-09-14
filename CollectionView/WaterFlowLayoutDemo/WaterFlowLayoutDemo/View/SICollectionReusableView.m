//
//  SICollectionReusableView.m
//  WaterFlowLayoutDemo
//
//  Created by 杨晴贺 on 9/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SICollectionReusableView.h"

@interface SICollectionReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation SICollectionReusableView

- (void)setTitle:(NSString *)title{
    _title = title ;
    self.label.text = title ;
}

@end
