//
//  ContentViewController.m
//  UISearchControllerDemo
//
//  Created by 杨晴贺 on 2017/6/1.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation ContentViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.searchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultCell"] ;
    }
    
    cell.textLabel.text = self.searchResults[indexPath.row];
    
    return cell;
}

@end
