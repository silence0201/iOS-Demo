//
//  InstagramFeedTableViewCell.h
//  SelfSizeCellDemo
//
//  Created by 杨晴贺 on 24/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InstagramItem ;
@class WPHotspotLabel ;

@interface InstagramFeedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet WPHotspotLabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIView *leftCircleView;
@property (weak, nonatomic) IBOutlet UIView *centerCircleView;
@property (weak, nonatomic) IBOutlet UIView *rightCircleView;

@property (nonatomic, strong) InstagramItem *instagramItem;

@end
