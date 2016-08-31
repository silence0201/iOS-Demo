//
//  MultipleChoicCell.h
//  PopMultipleChoiceDemo
//
//  Created by 杨晴贺 on 8/31/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultipleChoicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;  //cell内容
@property (weak, nonatomic) IBOutlet UIButton *cellChoice;  // cell是否选中

@end
