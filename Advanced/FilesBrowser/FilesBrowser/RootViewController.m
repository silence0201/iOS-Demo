//
//  RootViewController.m
//  FilesBrowser
//
//  Created by 杨晴贺 on 12/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "RootViewController.h"
#import "FileViewController.h"

static NSString *ContentsCellIdentifier = @"ContentsCell";
static NSString *DateCellIdentifier = @"DateCell";

@implementation RootViewController{
    NSString *creationDate;
    NSString *modificationDate;
    NSArray *contentsDirectories;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *currentPath = [self.fm currentDirectoryPath] ;
    NSDictionary *currentDitionary = [self.fm attributesOfItemAtPath:currentPath error:nil];
    creationDate = [[currentDitionary valueForKey:NSFileCreationDate] description];
    modificationDate = [[currentDitionary valueForKey:NSFileModificationDate] description];
    contentsDirectories = [self.fm contentsOfDirectoryAtPath:currentPath error:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    if(self.isPoped){
        [self.fm changeCurrentDirectoryPath:self.previousPath] ;
        self.isPoped = NO ;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 2){
        return [contentsDirectories count] ;
    }else{
        return 1 ;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:ContentsCellIdentifier] ;
    UITableViewCell *dateCell = [tableView dequeueReusableCellWithIdentifier:DateCellIdentifier] ;
    
    if(!contentCell){
        contentCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ContentsCellIdentifier] ;
    }
    
    if (!dateCell) {
        dateCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DateCellIdentifier] ;
    }
    
    NSInteger section = indexPath.section ;
    NSInteger row = indexPath.row ;
    
    if(section == 0){
        dateCell.textLabel.text = creationDate ;
        dateCell.textLabel.textColor = [UIColor redColor] ;
        return dateCell ;
    }else if(section == 1){
        dateCell.textLabel.text = modificationDate ;
        dateCell.textLabel.textColor = [UIColor redColor] ;
        return dateCell ;
    }else{
        contentCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        contentCell.textLabel.text = [contentsDirectories objectAtIndex:row] ;
        return contentCell ;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"创建日期" ;
    }else if (section == 1){
        return @"修改日期" ;
    }else{
        return @"内容" ;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        NSString *selectedPath = [contentsDirectories objectAtIndex:[indexPath row]] ;
        NSString *prePath = [self.fm currentDirectoryPath] ;
        BOOL flag = [self.fm changeCurrentDirectoryPath:selectedPath] ;
        
        //  目录
        if (flag){
            RootViewController *rootViewController = [[RootViewController alloc]init] ;
            rootViewController.fm = self.fm;
            rootViewController.title = selectedPath;
            
            self.previousPath = prePath;
            self.isPoped = YES;
            [self.navigationController pushViewController: rootViewController animated: YES];
        }else{
            // 文件
            FileViewController *fileVc = [[FileViewController alloc]init] ;
            NSString *path = selectedPath ;
            NSDictionary *file = [self.fm attributesOfItemAtPath:path error:nil] ;
            fileVc.creationDate = [[file valueForKey:NSFileCreationDate] description] ;
            fileVc.modificationDate = [[file valueForKey:NSFileModificationDate] description];
            fileVc.fileSize = [NSString stringWithFormat:@"Size:%@", [file valueForKey: NSFileSize]];
            fileVc.title = selectedPath;
            [self.navigationController pushViewController:fileVc animated: YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
}

@end
