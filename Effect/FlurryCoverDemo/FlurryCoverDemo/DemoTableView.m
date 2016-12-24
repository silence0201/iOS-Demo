//
//  DemoTableView.m
//  FlurryCoverDemo
//
//  Created by 杨晴贺 on 24/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "DemoTableView.h"
#import "UIScrollView+SIFlurryCover.h"

@implementation DemoTableView{
    UIView *_topView ;
}

- (void)viewDidLoad{
    [super viewDidLoad] ;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    [self.tableView addFlurryCoverWithImage:[UIImage imageNamed:@"cover"]];
    self.title = NSStringFromClass([self class]) ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %zd",indexPath.row + 1];
    
    return cell;
}

-(void)dealloc{
    [self.tableView removeFlurryCoverView] ;
}

@end
