//
//  InstagramFeedTableViewController.m
//  SelfSizeCellDemo
//
//  Created by 杨晴贺 on 24/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "InstagramFeedTableViewController.h"
#import "InstagramItem.h"
#import "InstagramFeedTableViewCell.h"
#import "UITableViewController+KYSelfSizingPushFix.h"

@interface InstagramFeedTableViewController ()

@property (nonatomic,strong) NSMutableArray *dataSource ;

@end

@implementation InstagramFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44.0 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension ;
    
    self.dataSource = [[InstagramItem newDataSource] mutableCopy ];
    [self ky_tableViewReloadData] ;
}

#pragma mark --- Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InstagramFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstagramFeedTableViewCellCellIdentifider" forIndexPath:indexPath] ;
    
    cell.instagramItem = self.dataSource[indexPath.row] ;
    
    if(![self ky_isEstimatedRowHeightInCache:indexPath]){
        CGSize cellSize = [cell systemLayoutSizeFittingSize:CGSizeMake(self.view.frame.size.width, 0) withHorizontalFittingPriority:1000.0 verticalFittingPriority:50.0];
        [self ky_putEstimatedCellHeightToCache:indexPath height:cellSize.height] ;
    }
    
    return cell ;
}

#pragma mark - UITableView Delegate
//给estimatedHeight返回缓存的之前正确的高度。return the height cache to the estimatedHeight
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self ky_getEstimatedCellHeightFromCache:indexPath defaultHeight:44.0];
}

@end
