//
//  FixCollectionViewCell.m
//  CollectionFixDemo
//
//  Created by Silence on 2019/1/17.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "FixCollectionViewCell.h"

@interface FixCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation FixCollectionViewCell

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
}

@end
