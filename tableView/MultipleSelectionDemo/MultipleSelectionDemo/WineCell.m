//
//  WineCell.m
//  MultipleSelectionDemo
//
//  Created by 杨晴贺 on 8/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "WineCell.h"
#import "Wine.h"

@interface WineCell ()

@property (weak, nonatomic) IBOutlet UIImageView *wineImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyWine;

@end

@implementation WineCell

// 重写模型的set方法
- (void)setWine:(Wine *)wine{
    // 必须要有对其赋值
    _wine = wine ;
    
    // 对cell进行赋值
    self.wineImageView.image = [UIImage imageNamed:wine.image] ;
    self.nameLabel.text = wine.name ;
    self.moneyWine.text = wine.money ;
    
}


@end
