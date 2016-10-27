//
//  SIModel.h
//  AutoLayoutCellDemo
//
//  Created by 杨晴贺 on 27/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SIModel : NSObject

@property (nonatomic,copy) NSString *headImageURL;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *mainImageURL;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,assign) CGFloat mainHeight;
@property (nonatomic,assign) CGFloat mainWidth;

@end
