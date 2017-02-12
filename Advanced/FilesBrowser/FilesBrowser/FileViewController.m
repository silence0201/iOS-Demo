//
//  FileViewController.m
//  FilesBrowser
//
//  Created by 杨晴贺 on 12/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "FileViewController.h"


static NSString *CellIdentifier = @"Cell";
@implementation FileViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.creationDate ;
        cell.textLabel.textColor = [UIColor redColor] ;
    }else if (indexPath.section == 1){
        cell.textLabel.text = self.modificationDate ;
        cell.textLabel.textColor = [UIColor redColor] ;
    }else{
        cell.textLabel.text = self.fileSize ;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"创建日期" ;
    }else if (section == 1){
        return @"修改日期" ;
    }else{
        return @"大小" ;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
}

@end
