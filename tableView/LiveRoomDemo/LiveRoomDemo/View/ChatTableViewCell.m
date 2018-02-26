//
//  ChatTableViewCell.m
//  LiveRoomDemo
//
//  Created by Silence on 2018/2/26.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ChatTableViewCell.h"

static NSString *const identifier = @"ChatTableViewCell";

@interface ChatTableViewCell ()
@property (nonatomic, strong) UIView *mainView;
@end


@implementation ChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.textLabel.font = [UIFont systemFontOfSize:14.0];
        self.textLabel.transform = CGAffineTransformMakeScale(1, -1);
        
        UIView *cornerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        cornerView.backgroundColor = [UIColor whiteColor];
        cornerView.layer.cornerRadius = 3.0;
        cornerView.layer.masksToBounds = YES;
        [self.contentView insertSubview:cornerView belowSubview:self.textLabel];
        self.mainView = cornerView;
    }
    return self;
}

+ (instancetype)crateChatTableViewCellWithTable:(UITableView *)tableView {
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setCellAttributTitle:(NSAttributedString *)str{
    // 这里就不考虑多行的情况了，可以根据具体需求具体对待
    self.textLabel.attributedText = str;
    CGRect rect = [str.string boundingRectWithSize:CGSizeMake(0, 18) options: NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
    self.mainView.frame = CGRectMake(0, 0, 30 + rect.size.width, 30);
}



@end
