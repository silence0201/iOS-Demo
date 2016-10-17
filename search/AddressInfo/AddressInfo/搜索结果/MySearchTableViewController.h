//
//  MySearchTableViewController.h
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MySearchTableViewController ;
@protocol SearchResultsDelegate <NSObject>

/**
 *
 *  @param resultVC 结果的控制器
 *  @param cityName   城市名
 */
- (void)resultViewController:(MySearchTableViewController*)resultVC didSelectFollowCity:(NSString*)cityName;

@end

@interface MySearchTableViewController : UITableViewController

@property (nonatomic,strong) NSArray *dataSource ;
@property (nonatomic,weak) id<SearchResultsDelegate> resultDelegate ;

@end
