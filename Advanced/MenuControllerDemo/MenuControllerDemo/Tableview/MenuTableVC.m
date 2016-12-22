//
//  MenuTableVC.m
//  MenuControllerDemo
//
//  Created by 杨晴贺 on 22/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MenuTableVC.h"
#import "DemoCell.h"

@interface MenuTableVC (){
    DemoCell *_selectedCell ;
}

@end

@implementation MenuTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[DemoCell class] forCellReuseIdentifier:@"cell"] ;
}

#pragma mark --- TableViewDelegate 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row] ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // menuControllerd的显示依赖第一相应者,当点击另外的cell时,当前cell取消第一响应者状态
    UIMenuController *menu = [UIMenuController sharedMenuController] ;
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES] ;
    }else{
        DemoCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
        _selectedCell = cell ;
        // 不设置为第一响应者无法显示
        [cell becomeFirstResponder] ;
        
        UIMenuItem * item0 = [[UIMenuItem alloc]initWithTitle:@"分享" action:@selector(share:)];
        UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"评论" action:@selector(comment:)];
        UIMenuItem * item2 = [[UIMenuItem alloc]initWithTitle:@"点赞" action:@selector(praise:)];
        menu.menuItems = @[item0,item1,item2];
        
        [menu setTargetRect:CGRectMake(0, cell.frame.size.height * 0.5, cell.frame.size.width, cell.frame.size.height) inView:cell];
        
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void)share:(UIMenuController *)menu{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享" message:_selectedCell.textLabel.text delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)comment:(UIMenuController *)menu{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"评论" message:_selectedCell.textLabel.text delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)praise:(UIMenuController *)menu{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"点赞" message:_selectedCell.textLabel.text delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
@end
