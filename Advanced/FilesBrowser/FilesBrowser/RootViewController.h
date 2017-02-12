//
//  RootViewController.h
//  FilesBrowser
//
//  Created by 杨晴贺 on 12/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController

@property (nonatomic,strong) NSFileManager *fm;
@property (nonatomic,strong) NSString *previousPath;
@property (nonatomic,assign) BOOL isPoped;

@end
