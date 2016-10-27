//
//  ViewController.m
//  AutoLayoutCellDemo
//
//  Created by 杨晴贺 on 27/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "SIModel.h"
#import "SIMyTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *dataSource ;

@end

@implementation ViewController

#pragma mark -- Life Cycle 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AutoLayout Cell" ;
    
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    [self initData] ;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SIMyTableViewCell" bundle:nil] forCellReuseIdentifier:@"SIMyTableViewCell"] ;
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0) ;
}

- (void)initData{
    NSArray *mainImage = @[@"http://qingdan.img.taowaitao.cn/image.php?ot=aHR0cDovL21tYml6LnFwaWMuY24vbW1iaXovMWxuRWx1VGFiMndyaWNtdFI1dlVRREUxeEJEMk5GR1F6TWd2SjdXQnJ4UkpLOG9uU0ZDMDFocWdjOGpVRGJ5bVRnN3daTElaQmV1RGpMMHZKQkZRZ1RBLzA/d3hfZm10PWpwZWc=",@"",@"http://qingdan.img.taowaitao.cn/image.php?ot=aHR0cDovL21tYml6LnFwaWMuY24vbW1iaXovajNzenRhSWxiMFlWVFVpYkJFZE1JUjlnUzllQmlha2xaMHFUQ3FCcGo5RFVEZ0JKRDMyeWN2VVc4OVZQMFJpYTJQNnJWVVRNMDJnVVcxVTgzd2NKWWw3OHcvMD93eF9mbXQ9anBlZw==",@"http://qingdan.img.taowaitao.cn/image.php?ot=aHR0cHM6Ly9vNC54aWFvaG9uZ3NodS5jb20vZGlzY292ZXJ5L3c2NDAvYjMzZTY1MDg0YmI1NzViY2E1ODYxNzZhY2M3Y2Q0YWZfNjQwXzY0MF85Mi5qcGc=",@"http://qingdan.img.taowaitao.cn/image.php?ot=aHR0cDovL21laWxhcHAucWluaXVjZG4uY29tL0ZpUHdQSXBqS0RtSFNwU0hrNi1SS1laWklDWDY=",@"http://qingdan.img.taowaitao.cn/image.php?ot=aHR0cDovL21laWxhcHAucWluaXVjZG4uY29tL0ZqUGUtSE1CX1d5X1pnUjFkam5zMGxNRWpfeGk="];
    NSArray *sizeArr = @[@"700,486",@"",@"564,575",@"640,640",@"750,750",@"645,968"];
    NSArray *userImage = @[@"http://twt.img.iwala.net/touxiang/56c344acdbb88.jpg",@"http://twt.img.iwala.net/touxiang/56c344a5a1054.jpg",@"http://twt.img.iwala.net/touxiang/56c342284128a.jpg",@"http://twt.img.iwala.net/touxiang/56384670e4787.jpg",@"",@"http://twt.img.iwala.net/touxiang/5638460884c06.jpg"];
    
    NSArray *descArr = @[@"愤怒的时间发货的收款计划发放贷款结构合理收费价格了快速分解管理会计师法规；建设路口；价格开始；浪费",@"愤怒的时间发货的收款计划发放贷款结构合理收费价格了快速分解管理会计师法规；建设路口；价格开始；浪费",@"建设路口；价格开始；浪费",@"合理收费价格了快速分解管理会计师法规",@"愤怒的时间发货的收款计划发放贷款结构合理收费价格了快速分解管",@"合理收费价格了快速分解管理会计师法规；建设路口"];
    
    for (NSInteger i = 0; i < 6; i ++){
        SIModel *model = [[SIModel alloc] init];
        model.headImageURL = userImage[i];
        model.userName = @"觅克璟";
        model.mainImageURL = mainImage[i];
        if (![sizeArr[i] isEqualToString:@""]){
            model.mainWidth = [[sizeArr[i] componentsSeparatedByString:@","][0] floatValue];
            model.mainHeight = [[sizeArr[i] componentsSeparatedByString:@","][1] floatValue];
        }else{
            model.mainWidth = 0;
            model.mainHeight = 0;
        }
        model.desc = descArr[i];
        [self.dataSource addObject:model];
    }

}

#pragma mark --  delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SIMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SIMyTableViewCell" forIndexPath:indexPath] ;
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    [self configCell:cell indexPath:indexPath] ;
    return cell ;
}

#pragma mark -- 高度的设定
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"SIMyTableViewCell" configuration:^(id cell) {
        [self configCell:cell indexPath:indexPath] ;
    }] ;
}


#pragma mark -- Lazy Load
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init] ;
    }
    return _dataSource ;
}

#pragma mark -- ConfigCell
- (void)configCell:(SIMyTableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    SIModel *model = self.dataSource[indexPath.row] ;
    cell.model = model ;
}



@end
