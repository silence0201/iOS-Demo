//
//  MySearchController.m
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MySearchController.h"
#import "MySearchTableViewController.h"

@interface MySearchController (){
    MySearchTableViewController *_resultViewController ;
}

@end

@implementation MySearchController

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        self.hidesNavigationBarDuringPresentation = YES ;
        self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x, self.searchBar.frame.origin.y, self.searchBar.frame.size.width, 44.0);
        self.searchBar.placeholder = @"城市/行政区/拼音";
        self.searchBar.searchBarStyle = UISearchBarStyleProminent;
        self.searchBar.returnKeyType = UIReturnKeyDone;
    }
    return self ;
}


@end
