//
//  ViewController.m
//  Font
//
//  Created by Silence on 2018/10/22.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "MyFontViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *fontList; // 所有字体列表

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    tableView.sectionHeaderHeight = 40 ;
    [self.view addSubview:tableView];
    
    self.fontList = [UIFont familyNames];
    
    for (NSString *fontFamilyName in self.fontList) {
        NSLog(@"FamilyName:%@",fontFamilyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
            NSLog(@">> %@",fontName);
        }
        
        NSLog(@">>>  end  <<<");
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fontList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *fontFamily = self.fontList[section];
    return [UIFont fontNamesForFamilyName:fontFamily].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    NSString *fontFamily = self.fontList[indexPath.section];
    NSArray *fonts = [UIFont fontNamesForFamilyName:fontFamily];
    UIFont *font = [UIFont fontWithName:fonts[indexPath.row] size:18];
    cell.textLabel.text = @"abc&123?ABC?字体!";
    cell.textLabel.font = font;
    cell.detailTextLabel.text = fonts[indexPath.row];
    cell.textLabel.textColor = [UIColor redColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *fontFamily = self.fontList[section];
    return fontFamily;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyFontViewController *vc = [[MyFontViewController alloc]init];
    NSString *fontFamily = self.fontList[indexPath.section];
    NSArray *fontStr = [UIFont fontNamesForFamilyName:fontFamily];
    vc.fontStr = fontStr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
