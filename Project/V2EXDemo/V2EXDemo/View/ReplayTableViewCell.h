//
//  ReplayTableViewCell.h
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplayTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UILabel *uName;
@property (nonatomic, weak) IBOutlet UILabel *createdDate;
@property (nonatomic, weak) IBOutlet UILabel *replayContent;

@end
