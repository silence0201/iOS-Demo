//
//  ViewController.m
//  UISearchControllerDemo
//
//  Created by 杨晴贺 on 2017/6/1.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "ContentViewController.h"

@interface ViewController ()<UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *airlines;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"airlineData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    self.airlines = dict[@"airlines"];
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:[[ContentViewController alloc] init]] ;
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x,
                                                       self.searchController.searchBar.frame.origin.y,
                                                       self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.airlines count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Airline"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Airline"] ;
    }
    cell.textLabel.text = [[self.airlines objectAtIndex:indexPath.row] objectForKey:@"Name"];
    return cell;
}


#pragma mark - UISearchControllerDelegate & UISearchResultsDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchString = self.searchController.searchBar.text;
    
    [self updateFilteredContentForAirlineName:searchString];
    
    if (self.searchController.searchResultsController) {
        ContentViewController *vc = (ContentViewController *)searchController.searchResultsController ;
        vc.searchResults = self.searchResults;
        [vc.tableView reloadData];
        [vc.tableView setAllowsSelection:NO] ;
        vc.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
}


- (void)updateFilteredContentForAirlineName:(NSString *)airlineName{
    
    if (airlineName == nil) {
        self.searchResults = [self.airlines mutableCopy];
    } else {
        NSMutableArray *searchResults = [[NSMutableArray alloc] init];
        for (NSDictionary *airline in self.airlines) {
            if ([airline[@"Name"] containsString:airlineName]) {
                NSString *str = [NSString stringWithFormat:@"%@", airline[@"Name"] /*, airline[@"icao"]*/];
                [searchResults addObject:str];
            }
            
            self.searchResults = searchResults;
        }
    }
}


@end
