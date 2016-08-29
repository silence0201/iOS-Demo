//
//  HeaderView.m
//  ListTableView
//
//  Created by 杨晴贺 on 8/29/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "HeaderView.h"
#import "FriendGroup.h"

@interface HeaderView ()

@property (nonatomic,weak) UILabel *countView ;
@property (nonatomic,weak) UIButton *nameView ;

@end

@implementation HeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"headView" ;
    HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier] ;
    if (headerView == nil) {
        headerView = [[HeaderView alloc]initWithReuseIdentifier:identifier] ;
    }
    return headerView ;
}

// 初始化,否则不显示
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        
        // 添加按钮
        UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        //设置背景图片
        [nameBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted] ;
        //设置内部的箭头突变
        [nameBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal] ;
        [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        //设置按钮内容左对齐
        nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
        // 设置按钮内部的边距
        nameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0) ;
        nameBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0) ;
        [nameBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside] ;
        
        // 设置按钮内部的imageView的内容模式为居中
        nameBtn.imageView.contentMode = UIViewContentModeCenter ;
        
        //超出的不炫耀裁剪
        nameBtn.imageView.clipsToBounds = NO ;
        
        [self.contentView addSubview:nameBtn] ;
        
        // 添加好友数
        UILabel *countView = [[UILabel alloc]init] ;
        countView.textAlignment = NSTextAlignmentCenter ;
        countView.textColor = [UIColor grayColor] ;
        [self.contentView addSubview:countView] ;
        
        self.nameView = nameBtn ;
        self.countView = countView ;
    }
    
    return self ;
}

- (void)btnClick{
    self.group.open = !self.group.isOpen ;
    
    // 刷新表格
    if([self.delegate respondsToSelector:@selector(headerViewDidClickedNameView:)]){
        [self.delegate headerViewDidClickedNameView:self] ;
    }
}


/**
 *  写入模型model
 *
 *  @param group model
 */
- (void)setGroup:(FriendGroup *)group{
    _group = group ;
    
    // 设置组名
    [self.nameView setTitle:group.name forState:UIControlStateNormal] ;
    
    // 设置好友数
    self.countView.text = [NSString stringWithFormat:@"%ld / %ld",group.online,group.friends.count] ;
    
    // 设置左边的箭头状态
    [self didMoveToSuperview] ;
}

/**
 *  当空间的frame发生变化会调用,一般用来布局子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews] ;
    
    // 设置按钮的frame
    self.nameView.frame = self.bounds ;
    
    // 设置好友数的frame
    CGFloat countY = 0 ;
    CGFloat countH = self.frame.size.height ;
    CGFloat countW = 150 ;
    CGFloat countX = self.frame.size.width - 10 -countW ;
    
    self.countView.frame = CGRectMake(countX, countY, countW, countH) ;
}

/**
 *  当空间被添加到父控件被调用
 */
- (void)didMoveToSuperview{
    if(self.group.isOpen){
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2) ;
    }else{
        self.nameView.imageView.transform = CGAffineTransformIdentity ;
    }
}

@end
