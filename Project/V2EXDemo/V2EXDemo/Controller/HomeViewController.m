//
//  HomeViewController.m
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "HomeViewController.h"
#import "LeftMenuViewController.h"
#import "DetailViewController.h"
#import "UIViewController+MMDrawerController.h"

#import "Reachability.h"

#import "FLEXManager.h"

#import "SIV2DataManager.h"

#import "ArticleTableViewCell.h"
#import "UIImageView+WebCache.h"

#import "MJRefresh.h"
#import "MJDIYHeader.h"

#import "MSGStatusToast.h"

#import "Node.h"
#import "ChildNode.h"
#import "List.h"

extern NSArray *__nodeArr;

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,NodeSelectedDelegate,UIViewControllerPreviewingDelegate>{
    // cell标题的宽度
    CGFloat cellTitleWidth ;
    // 刷新头
    MJDIYHeader *header ;
    // 页码
    NSInteger page ;
    // 父节点code
    NSString *fatherNodeCode ;
    // 子节点code
    NSString *childNodeCode ;
    // 子节点name
    NSString *childNodeName ;
    // 子节点对象数组
    NSArray *childNodeArray ;
    // 刷新的是否是子节点
    BOOL isRequestChildNode ;
    // 子节点Table
    UITableView *childNodeTable ;
}

@property (nonatomic,strong) UITableView *mainTable ;  // 主要内容TableView
@property (nonatomic,strong) UIView *nodeBackgroundView ;  // 选择节点View
@property (nonatomic,strong) UIButton *childNodeButton ; // 子节点菜单开关按钮

@property (nonatomic,strong) NSMutableArray *articleDataArray ;

@end

@implementation HomeViewController

#pragma mark --- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor] ;
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_menu_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(leftDrawerButtonPress)] ;
    self.navigationItem.leftBarButtonItem = barItem ;
    
    // 默认刷新的不是子节点
    isRequestChildNode = NO ;
    // 页码
    page = 1 ;
    // 默认父节点的名称
    fatherNodeCode = @"all" ;
    // 设置左边菜单协议
    LeftMenuViewController *left = (LeftMenuViewController *)self.mm_drawerController.leftDrawerViewController;
    left.delegate = self;
    // 默认父节点对象
    Node *node = __nodeArr[9] ;
    // 获取父节点对象的子节点对象
    childNodeArray = node.childNodeArray ;
    
    cellTitleWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 32;
    // Nav Menu
    self.navigationItem.titleView = self.childNodeButton ;
    [self.view addSubview:self.mainTable] ;
    [self setReloadHeader] ;
    // 开始刷新
    [header beginRefreshing] ;
    // 添加节点菜单
    [self.view addSubview:self.nodeBackgroundView] ;
    
#if DEBUG
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"DEBUG" style:UIBarButtonItemStylePlain target:self action:@selector(flexButtonTapped:)];
#endif
    
    [self registerForPreviewingWithDelegate:self sourceView:self.view] ;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    // 开启左划
    [self.navigationController.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll] ;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated] ;
    // 禁止左划
    [self.navigationController.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone] ;
}

#pragma mark --- Lazy Load
-  (UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
        _mainTable.delegate = self ;
        _mainTable.dataSource = self ;
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone ;
    }
    return _mainTable ;
}

- (UIView *)nodeBackgroundView{
    if (!_nodeBackgroundView) {
        _nodeBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), 0)] ;
        _nodeBackgroundView.backgroundColor = [UIColor whiteColor] ;
        _nodeBackgroundView.clipsToBounds = YES ;
        
        childNodeTable = [[UITableView alloc]initWithFrame:self.nodeBackgroundView.bounds style:UITableViewStylePlain] ;
        childNodeTable.delegate = self ;
        childNodeTable.dataSource = self ;
        childNodeTable.scrollEnabled = NO ;
        childNodeTable.backgroundColor = [UIColor whiteColor] ;
        childNodeTable.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched ;
        [_nodeBackgroundView addSubview:childNodeTable] ;
    }
    return _nodeBackgroundView ;
}

- (UIButton *)childNodeButton{
    if (!_childNodeButton) {
        _childNodeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)] ;
        [_childNodeButton setTitle:@"全部" forState:UIControlStateNormal] ;
        _childNodeButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f] ;
        _childNodeButton.tag = 100 ;
        [_childNodeButton addTarget:self action:@selector(childButtonAction:) forControlEvents:UIControlEventTouchUpInside] ;
    }
    return _childNodeButton ;
}

- (NSMutableArray *)articleDataArray{
    if(!_articleDataArray){
        _articleDataArray = [NSMutableArray array] ;
    }
    return _articleDataArray ;
}

- (void)setReloadHeader{
    header = [MJDIYHeader headerWithRefreshingBlock:^{
        if(![self hasNetWorking]){
            [[MSGStatusToast shareMSGToast] showError:@"网络连接异常,检查网络连接" autoHide:YES] ;
            [self.mainTable.footer endRefreshing] ;
        }
        page = 1 ;
        [self loadData] ;
    }] ;
    [header placeSubviews] ;
    self.mainTable.header = header ;
    
    self.mainTable.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if(![self hasNetWorking]){
            [[MSGStatusToast shareMSGToast]showError:@"网络连接异常" autoHide:YES] ;
            [self.mainTable.footer endRefreshing] ;
        }
        if(isRequestChildNode){
            page += 1 ;
            [self loadData] ;
        }else{
            [self.mainTable.footer endRefreshing] ;
        }
    }] ;
}

#pragma mark --- Action
- (void)childButtonAction:(UIButton *)sender{
    if(sender.tag == 100){
        // 刷新子节点数据
        childNodeTable.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), childNodeArray.count*44);
        [childNodeTable reloadData] ;
        [UIView animateWithDuration:0.25 animations:^{
            self.nodeBackgroundView.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), childNodeArray.count*44);
        }];
        sender.tag = 101 ;
    }else{
        [UIView animateWithDuration:0.25
                         animations:^{
                             self.nodeBackgroundView.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), 0);
                         }
                         completion:^(BOOL finished) {
                             childNodeTable.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 0);
                         }];
        sender.tag = 100;
    }
}

- (void)leftDrawerButtonPress{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil] ;
}

- (void)flexButtonTapped:(id)sender {
#if DEBUG
    [[FLEXManager sharedManager]setNetworkDebuggingEnabled:YES] ;
    [[FLEXManager sharedManager] showExplorer];
#endif
}

#pragma mark --- Load Data
-(void)loadData{
    [[SIV2DataManager shareManager]getArticleListWithNodeCode:isRequestChildNode ? childNodeCode:fatherNodeCode
                                                     codeName:childNodeName
                                                 requestChild:isRequestChildNode
                                                         Page:page
                                                      isCache:YES
                                               isStorageCache:YES
                                              V2RequestPolicy:SIV2RequestFallUseCache
                                                      Success:^(NSArray *listArray) {
                                                          [self.articleDataArray removeAllObjects] ;
                                                          [self.articleDataArray addObjectsFromArray:listArray] ;
                                                          if(self.articleDataArray.count != 0){
                                                              [self.mainTable reloadData] ;
                                                          }
                                                          [header endRefreshing] ;
                                                          [self.mainTable.footer endRefreshing] ;
                                                      } failure:^(NSError *error) {
                                                          [header endRefreshing] ;
                                                          [self.mainTable.footer endRefreshing] ;
                                                      }] ;
}

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

#pragma mark --- UITbaleViewDelegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:childNodeTable]) {
        return childNodeArray.count ;
    }else{
        return self.articleDataArray.count ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:childNodeTable]){
        static NSString *cellID = @"node" ;
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID] ;
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] ;
            cell.backgroundColor = [UIColor whiteColor] ;
        }
        
        ChildNode *childNode = childNodeArray[indexPath.row] ;
        cell.textLabel.text = childNode.childNodeName ;
        cell.textLabel.textColor = [UIColor blackColor] ;
        cell.textLabel.font = [UIFont systemFontOfSize:13] ;
        return cell ;
    }else{
        static NSString *cellID = @"cell" ;
        
        ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID] ;
        if(!cell){
            cell =[[[NSBundle mainBundle] loadNibNamed:@"ArticleTableViewCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            cell.userAvatar.layer.cornerRadius = CGRectGetWidth(cell.userAvatar.frame) * 0.5f ;
            cell.userAvatar.layer.masksToBounds = YES ;
            cell.frame = [UIScreen mainScreen].bounds ;
        }
        List *news = self.articleDataArray[indexPath.row] ;
        cell.articleTitltLable.text = news.articleTitle;
        cell.createdLable.text = [NSString stringWithFormat:@"%@/%@ 回复",news.createdDate,news.replayCount];
        cell.userName.text = [NSString stringWithFormat:@"@%@",news.userName];
        [cell.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",news.userAvatar]] placeholderImage:[UIImage imageNamed:@"avatar_plasehoder"]];
        cell.nodeName.text = news.nodeName;
        return cell ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:childNodeTable]) {
        return 44.0f ;
    }else{
        List *news = self.articleDataArray[indexPath.row] ;
        NSString *dataString = news.articleTitle;
        UIFont *dataFont = [UIFont systemFontOfSize:14];
        CGSize titleSize = [dataString boundingRectWithSize:CGSizeMake(cellTitleWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:dataFont} context:nil].size;
        return 107 + titleSize.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:childNodeTable]) {
        // 选取子节点的时候重置页码
        page = 1 ;
        // 是否刷新的子节点
        isRequestChildNode = YES ;
        // 获取子节点对象
        ChildNode *childNode = childNodeArray[indexPath.row] ;
        // 获取子节点的名字
        childNodeName = childNode.childNodeName ;
        // 获取子节点的code
        childNodeCode = childNode.childNodeCode ;
        // 更改Title
        if (childNodeArray.count != 0) {
            [self.childNodeButton setTitle:[NSString stringWithFormat:@"%@ ▽",childNodeName] forState:UIControlStateNormal];
        }else{
            [self.childNodeButton setTitle:childNodeName forState:UIControlStateNormal];
        }
        // 关闭子节点菜单
        self.childNodeButton.tag = 101 ;
        [self childButtonAction:self.childNodeButton] ;
        // 判断选区的内容是否需要登录权限
        if ([childNodeCode isEqualToString:@"outsourcing"]||
            [childNodeCode isEqualToString:@"all4all"]||
            [childNodeCode isEqualToString:@"exchange"]||
            [childNodeCode isEqualToString:@"free"]||
            [childNodeCode isEqualToString:@"dn"]||
            [childNodeCode isEqualToString:@"tuan"]) {
            [self.articleDataArray removeAllObjects];
            [self.mainTable reloadData];
        }else{
            // 请求数据
            [self.mainTable.header beginRefreshing];
        }
    }else{
        DetailViewController *detailVc = [[DetailViewController alloc]init] ;
        detailVc.info = self.articleDataArray[indexPath.row] ;
        [self.navigationController pushViewController:detailVc animated:YES] ;
    }
}

#pragma mark --- NodeSelectedDelegate
- (void)nodeSelectedCode:(NSString *)code Name:(NSString *)name Index:(NSInteger)index{
    // 重置页码
    page = 1 ;
    // 是否刷新了子节点
    isRequestChildNode = NO ;
    // 父节点的code
    fatherNodeCode = code ;
    // 对应父节点对象
    Node *node = __nodeArr[index] ;
    // 选取父节点,取出对应的子节点数组
    childNodeArray = node.childNodeArray ;
    //设置header title
    if (childNodeArray.count != 0) {
        [self.childNodeButton setTitle:[NSString stringWithFormat:@"%@ ▽",name] forState:UIControlStateNormal];
    }else{
        [self.childNodeButton setTitle:name forState:UIControlStateNormal];
    }
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        [self.mainTable.header beginRefreshing] ;
    }] ;
    
    self.childNodeButton.tag = 101 ;
    [self childButtonAction:self.childNodeButton] ;
}

#pragma mark --- UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    CGPoint point = [previewingContext.sourceView convertPoint:location toView:self.mainTable] ;
    NSIndexPath *indexPath = [self.mainTable indexPathForRowAtPoint:point] ;
    if([self.presentedViewController isKindOfClass:[DetailViewController class]]){
        return nil ;
    }else{
        DetailViewController *detailVc = [[DetailViewController alloc]init] ;
        detailVc.info = self.articleDataArray[indexPath.row] ;
        detailVc.baseViewController = self ;
        return detailVc ;
    }
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    DetailViewController *detailVc = (DetailViewController *)viewControllerToCommit ;
    [self.navigationController pushViewController:detailVc animated:YES] ;
}



@end
