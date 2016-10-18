//
//  HeadView.m
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "HeadView.h"

@interface HeadView ()

@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"HeadView" owner:nil options:nil]lastObject] ;
    }
    return self ;
}

- (void)setHeadName:(NSString *)headName{
    _headName = headName ;
    _headLabel.text = headName ;
}

@end
