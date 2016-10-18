//
//  ItemViewCell.m
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ItemViewCell.h"

@interface ItemViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;


@end

@implementation ItemViewCell

- (void)awakeFromNib{
    self.layer.cornerRadius = 6 ;
    self.layer.masksToBounds = YES ;
    
    [super awakeFromNib] ;
}

- (void)setCityName:(NSString *)cityName{
    _cityName = cityName ;
    self.cityNameLabel.text = cityName ;
}


@end
