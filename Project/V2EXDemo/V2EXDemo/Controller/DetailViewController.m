//
//  DetailViewController.m
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "DetailViewController.h"

#import "ReplayTableViewCell.h"

#import "Reachability.h"

#import "UIImageView+WebCache.h"
#import "NSString+TimeTamp.h"

#import "SIV2DataManager.h"

#import "Replay.h"


@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UILabel *artTitle ;
    UIImageView *userAvatar ;
    UILabel *userName ;
    UILabel *replayCount ;
    UILabel *nodeName ;
    UILabel *timeLabel ;
    UILabel *bottomLine ;
    UITextView *articleLabel ;
    
    NSString *content ;
    NSArray *replayDataArray ;
    CGFloat cellContentWidth ;
}

@property (nonatomic,strong) UITableView *detailTableView ;
@property (nonatomic,strong) UIView *headerView ;

@end

@implementation DetailViewController

#pragma mark --- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细内容" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    cellContentWidth = [UIScreen mainScreen].bounds.size.width - 69;
    [self.view addSubview:self.detailTableView] ;
    [self loadData] ;
    
}

#pragma mark -- Lazy Load
- (UITableView *)detailTableView{
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc]initWithFrame:self.view.bounds] ;
        _detailTableView.delegate = self ;
        _detailTableView.dataSource = self ;
        _detailTableView.backgroundColor = [UIColor whiteColor] ;
        _detailTableView.tableHeaderView = self.headerView ;
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    }
    return _detailTableView ;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.clipsToBounds = YES;
        
        NSString *dataString = self.info.articleTitle;
        UIFont *dataFont = [UIFont systemFontOfSize:14];
        CGSize titleSize = [dataString boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)-54, 400) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:dataFont} context:nil].size;
        artTitle = [[UILabel alloc] init];
        artTitle.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
        artTitle.font = dataFont;
        artTitle.numberOfLines = 0;
        artTitle.frame = CGRectMake(8, 10, titleSize.width, titleSize.height);
        artTitle.text  = self.info.articleTitle;
        [_headerView addSubview:artTitle];
        
        userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-38, 8, 30, 30)];
        userAvatar.backgroundColor = [UIColor clearColor];
        userAvatar.layer.cornerRadius = 3;
        userAvatar.layer.masksToBounds = YES;
        [userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",self.info.userAvatar]] placeholderImage:[UIImage imageNamed:@"avatar_plasehoder"]];
        [_headerView addSubview:userAvatar];
        
        CGFloat uTagX = artTitle.frame.size.height<17?artTitle.frame.size.height+30:artTitle.frame.size.height+13;
        UILabel *uTag = [[UILabel alloc] initWithFrame:CGRectMake(8, uTagX, 20, 20)];
        uTag.text = @"By";
        uTag.font = [UIFont systemFontOfSize:13];
        uTag.textColor = [UIColor grayColor];
        [_headerView addSubview:uTag];
        
        userName = [[UILabel alloc] init];
        UIFont *nameFont = [UIFont boldSystemFontOfSize:12];
        CGSize nameSize = [self.info.userName boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nameFont} context:nil].size;
        userName.font = nameFont;
        userName.numberOfLines = 0;
        userName.textColor = [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1];
        userName.frame = CGRectMake(28, uTag.frame.origin.y, nameSize.width, 20);
        userName.text = self.info.userName;
        [_headerView addSubview:userName];
        
        replayCount = [[UILabel alloc] init];
        UIFont *countFont = [UIFont systemFontOfSize:13];
        CGSize countSize = [[NSString stringWithFormat:@"%@ 回复",self.info.replayCount] boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:countFont} context:nil].size;
        replayCount.font = countFont;
        replayCount.numberOfLines = 0;
        replayCount.textColor = [UIColor grayColor];
        replayCount.frame = CGRectMake(userName.frame.origin.x+userName.frame.size.width+8, uTag.frame.origin.y, countSize.width, 20);
        replayCount.text = [NSString stringWithFormat:@"%@ 回复",self.info.replayCount];
        [_headerView addSubview:replayCount];
        
        nodeName = [[UILabel alloc] init];
        UIFont *nodeFont = [UIFont systemFontOfSize:13];
        CGSize nodeSize = [self.info.nodeName boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nodeFont} context:nil].size;
        nodeName.font = nameFont;
        nodeName.numberOfLines = 0;
        nodeName.textColor = [UIColor whiteColor];
        nodeName.backgroundColor = [UIColor lightGrayColor];
        nodeName.textAlignment = NSTextAlignmentCenter;
        nodeName.layer.cornerRadius = 3;
        nodeName.layer.masksToBounds = YES;
        nodeName.frame = CGRectMake(replayCount.frame.origin.x+replayCount.frame.size.width+8, uTag.frame.origin.y, nodeSize.width+4, 20);
        nodeName.text = self.info.nodeName;
        [_headerView addSubview:nodeName];
        
        timeLabel = [[UILabel alloc] init];
        bottomLine = [[UILabel alloc] init];
        bottomLine.frame = CGRectMake(8, uTag.frame.origin.y+26, CGRectGetWidth([UIScreen mainScreen].bounds)-16, 0.5);
        bottomLine.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1];
        [_headerView addSubview:bottomLine];
        
        articleLabel = [[UITextView alloc] init];
        [_headerView addSubview:articleLabel];
        
        _headerView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), bottomLine.frame.origin.y+2) ;
    }
    return _headerView ;
}

#pragma mark -- Load Data
- (void)loadData{
    NSArray *artUrlArr = [self.info.replayUrl componentsSeparatedByString:@"#"];
    NSArray *artIDArr = [artUrlArr[0] componentsSeparatedByString:@"/t/"];
    
    [[SIV2DataManager shareManager] getArticleReplayListWithPID:artIDArr[1]
                                                        Success:^(NSArray *listArray) {
        replayDataArray = listArray ;
        [self.detailTableView reloadData] ;
    } failure:^(NSError *error) {
        
    }] ;
    
    [[SIV2DataManager shareManager] getArticleContentWithPID:artIDArr[1]
                                                     Success:^(NSArray *contentArr) {
        content = contentArr.firstObject ;
        UIFont *countFont = [UIFont systemFontOfSize:14];
        CGSize countSize = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)-16, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:countFont} context:nil].size;
        articleLabel.font = countFont;
        articleLabel.editable = NO;
        articleLabel.scrollEnabled = NO;
        articleLabel.textColor = [UIColor grayColor];
        articleLabel.frame = CGRectMake(8, userName.frame.origin.y+33, CGRectGetWidth([UIScreen mainScreen].bounds)-16, countSize.height+40);
        articleLabel.text = content;
        self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), articleLabel.frame.origin.y+articleLabel.frame.size.height);
        
        NSString *createdTime =contentArr[1];
        
        UIFont *timeFont = [UIFont systemFontOfSize:13];
        CGSize timeSize = [createdTime boundingRectWithSize:CGSizeMake(350, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:timeFont} context:nil].size;
        timeLabel.font = timeFont;
        timeLabel.numberOfLines = 0;
        
        timeLabel.textColor = [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1];
        timeLabel.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-timeSize.width-8, nodeName.frame.origin.y, timeSize.width, 20);
        timeLabel.text = createdTime;
        [_headerView addSubview:timeLabel];
        
        [self.detailTableView reloadData];

    } failure:^(NSError *error) {
        
    }] ;
    
}

#pragma mark --- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return replayDataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    ReplayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ReplayTableViewCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Replay *replay = replayDataArray[indexPath.row];
    
    cell.uName.text = [NSString stringWithFormat:@"@%@",replay.memberName];
    cell.createdDate.text = [replay.replayDate toTimeTamp] ;
    
    UIFont *countFont = [UIFont systemFontOfSize:14];
    CGSize countSize = [replay.replayContent boundingRectWithSize:CGSizeMake(cellContentWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:countFont} context:nil].size;
    UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(58, 40, cellContentWidth-8, countSize.height)];
    contentLable.font = [UIFont systemFontOfSize:14];
    contentLable.text = replay.replayContent;
    contentLable.numberOfLines = 0;
    contentLable.textColor = [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1];
    [cell.contentView addSubview:contentLable];
    
    cell.avatar.layer.cornerRadius = 3;
    cell.avatar.layer.masksToBounds = YES;
    [cell.avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",replay.memberAvatar]] placeholderImage:[UIImage imageNamed:@"avatar_plasehoder"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Replay *replay = replayDataArray[indexPath.row] ;
    UIFont *countFont  = [UIFont systemFontOfSize:14];
    CGSize countSize   = [replay.replayContent boundingRectWithSize:CGSizeMake(cellContentWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:countFont} context:nil].size;
    return countSize.height + 50;
}

#pragma mark --- Private Method 
- (BOOL)hasNetWorking{
    Reachability *reacha = [Reachability reachabilityWithHostName:@"http://v2ex.com"];
    switch (reacha.currentReachabilityStatus) {
        case kNotReachable:
            return NO;
            break;
        case kReachableViaWiFi:
            return YES;
            break;
        case kReachableViaWWAN:
            return YES;
            break;
            
        default:
            return YES;
            break;
    }
}

#pragma mark --- 3DTouch菜单
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction *itemA = [UIPreviewAction actionWithTitle:@"查看详情" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        DetailViewController *detailVc = (DetailViewController *)previewViewController ;
        [detailVc.baseViewController.navigationController pushViewController:detailVc animated:YES] ;
    }] ;
    return @[itemA] ;
}




@end
