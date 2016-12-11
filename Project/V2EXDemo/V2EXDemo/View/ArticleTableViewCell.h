//
//  ArticleTableViewCell.h
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell

@property (nonatomic , weak) IBOutlet UIImageView *userAvatar;
@property (nonatomic , weak) IBOutlet UILabel *articleTitltLable;
@property (nonatomic , strong) IBOutlet UILabel *createdLable;
@property (nonatomic , strong) IBOutlet UILabel *userName;
@property (nonatomic , strong) IBOutlet UILabel *nodeName;

@end
