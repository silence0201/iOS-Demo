//
//  FileViewController.h
//  FilesBrowser
//
//  Created by 杨晴贺 on 12/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileViewController : UITableViewController

@property (nonatomic,copy) NSString *creationDate;
@property (nonatomic,copy) NSString *modificationDate;
@property (nonatomic,copy) NSString *fileSize;

@end
