//
//  InstagramItem.h
//  SelfSizeCellDemo
//
//  Created by 杨晴贺 on 24/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstagramItem : NSObject

@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSAttributedString *attrbutedComment;
@property (nonatomic, strong) UIImage *photo;

+ (NSArray *)newDataSource;

@end
