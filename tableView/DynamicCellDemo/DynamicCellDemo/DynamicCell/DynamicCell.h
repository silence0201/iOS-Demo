//
//  DynamicCell.h
//  DynamicCellDemo
//
//  Created by 杨晴贺 on 9/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const DynamicCellNotice ;

@class CellFrameModel ;
@interface DynamicCell : UITableViewCell

@property (nonatomic,strong) CellFrameModel *frameModel ;

- (void)showCellWithModel:(CellFrameModel *)frameModel indexPath:(NSIndexPath *)indexPath ;

@end
