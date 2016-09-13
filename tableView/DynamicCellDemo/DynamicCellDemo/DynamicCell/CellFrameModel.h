//
//  CellFrameModel.h
//  DynamicCellDemo
//
//  Created by 杨晴贺 on 9/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CellModel ;
@interface CellFrameModel : NSObject

@property (nonatomic,assign,readonly) CGRect iconF ;
@property (nonatomic,assign,readonly) CGRect nameF ;
@property (nonatomic,assign,readonly) CGRect textF ;
@property (nonatomic,assign,readonly) CGRect pictureF ;

@property (nonatomic,assign,readonly) CGFloat cellHeight ;
@property (nonatomic,strong) CellModel *cellModel ;

@end
