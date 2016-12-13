//
//  LeftMenuViewController.m
//  V2EXDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "LeftMenuViewController.h"

#import "Node.h"
#import "ChildNode.h"

NSArray *__nodeArr ;
@interface LeftMenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *nodeTableView ;
@property (nonatomic,strong) UIView *headerView ;

@end

@implementation LeftMenuViewController

#pragma mark --- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData] ;
    [self.view addSubview:self.nodeTableView] ;
    
}

#pragma mark --- Lazy Load
- (UITableView *)nodeTableView{
    if (!_nodeTableView) {
        _nodeTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
        _nodeTableView.delegate = self ;
        _nodeTableView.dataSource = self ;
        _nodeTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _nodeTableView.backgroundColor = [UIColor colorWithRed:67/255.0 green:176/255.0 blue:248/255.0 alpha:1.0];
    }
    return _nodeTableView ;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)] ;
        _headerView.backgroundColor =  [UIColor colorWithRed:67/255.0 green:176/255.0 blue:248/255.0 alpha:1.0] ;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 64)] ;
        label.text = @"节点:" ;
        label.textAlignment = NSTextAlignmentCenter ;
        label.center = _headerView.center ;
        [_headerView addSubview:label] ;
    }
    return _headerView ;
}

#pragma mark --- 初始化数据模型
- (void)initData{
    Node *nodeJs = [[Node alloc]initWithNodeName:@"技术" NodeCode:@"tect"] ;
    ChildNode *cn1 = [[ChildNode alloc] initWithChildNodeName:@"程序员" CNode:@"programmer"];
    ChildNode *cn2 = [[ChildNode alloc] initWithChildNodeName:@"Python" CNode:@"python"];
    ChildNode *cn3 = [[ChildNode alloc] initWithChildNodeName:@"iDev" CNode:@"idev"];
    ChildNode *cn4 = [[ChildNode alloc] initWithChildNodeName:@"Android" CNode:@"android"];
    ChildNode *cn5 = [[ChildNode alloc] initWithChildNodeName:@"Linux" CNode:@"linux"];
    ChildNode *cn6 = [[ChildNode alloc] initWithChildNodeName:@"node.js" CNode:@"nodejs"];
    ChildNode *cn7 = [[ChildNode alloc] initWithChildNodeName:@"云计算" CNode:@"cloud"];
    ChildNode *cn8 = [[ChildNode alloc] initWithChildNodeName:@"宽带症候群" CNode:@"bb"];
    NSArray *jSArr = @[cn1,cn2,cn3,cn4,cn5,cn6,cn7,cn8] ;
    nodeJs.childNodeArray = jSArr ;
    
    Node *nodeCy = [[Node alloc]initWithNodeName:@"创意" NodeCode:@"creative"] ;
    ChildNode *cy1 = [[ChildNode alloc] initWithChildNodeName:@"分享创造" CNode:@"create"];
    ChildNode *cy2 = [[ChildNode alloc] initWithChildNodeName:@"设计" CNode:@"design"];
    ChildNode *cy3 = [[ChildNode alloc] initWithChildNodeName:@"奇思妙想" CNode:@"ideas"];
    NSArray *cYArr = @[cy1,cy2,cy3] ;
    nodeCy.childNodeArray = cYArr ;
    
    Node *nodeHw  = [[Node alloc] initWithNodeName:@"好玩" NodeCode:@"play"];
    ChildNode *hw1 = [[ChildNode alloc] initWithChildNodeName:@"分享发现" CNode:@"share"];
    ChildNode *hw2 = [[ChildNode alloc] initWithChildNodeName:@"电子游戏" CNode:@"games"];
    ChildNode *hw3 = [[ChildNode alloc] initWithChildNodeName:@"电影" CNode:@"movie"];
    ChildNode *hw4 = [[ChildNode alloc] initWithChildNodeName:@"剧集" CNode:@"tv"];
    ChildNode *hw5 = [[ChildNode alloc] initWithChildNodeName:@"音乐" CNode:@"music"];
    ChildNode *hw6 = [[ChildNode alloc] initWithChildNodeName:@"旅游" CNode:@"travel"];
    ChildNode *hw7 = [[ChildNode alloc] initWithChildNodeName:@"Android" CNode:@"android"];
    ChildNode *hw8 = [[ChildNode alloc] initWithChildNodeName:@"午夜俱乐部" CNode:@"afterdark"];
    NSArray *hWArr = @[hw1,hw2,hw3,hw4,hw5,hw6,hw7,hw8];
    nodeHw.childNodeArray = hWArr;
    
    Node *nodeAp  = [[Node alloc] initWithNodeName:@"Apple" NodeCode:@"apple"];
    ChildNode *ap1 = [[ChildNode alloc] initWithChildNodeName:@"Mac OS X" CNode:@"macosx"];
    ChildNode *ap2 = [[ChildNode alloc] initWithChildNodeName:@"iPhone" CNode:@"iphone"];
    ChildNode *ap3 = [[ChildNode alloc] initWithChildNodeName:@"iPad" CNode:@"ipad"];
    ChildNode *ap4 = [[ChildNode alloc] initWithChildNodeName:@"MBP" CNode:@"mbp"];
    ChildNode *ap5 = [[ChildNode alloc] initWithChildNodeName:@"iMac" CNode:@"imac"];
    ChildNode *ap6 = [[ChildNode alloc] initWithChildNodeName:@"Apple" CNode:@"apple"];
    NSArray *aPArr = @[ap1,ap2,ap3,ap4,ap5,ap6];
    nodeAp.childNodeArray = aPArr;
    
    Node *nodeKGZ = [[Node alloc] initWithNodeName:@"酷工作" NodeCode:@"jobs"];
    ChildNode *kgz1 = [[ChildNode alloc] initWithChildNodeName:@"酷工作" CNode:@"jobs"];
    ChildNode *kgz2 = [[ChildNode alloc] initWithChildNodeName:@"求职" CNode:@"cv"];
    ChildNode *kgz3 = [[ChildNode alloc] initWithChildNodeName:@"外包" CNode:@"outsourcing"];
    NSArray *KGZarr = @[kgz1,kgz2,kgz3];
    nodeKGZ.childNodeArray = KGZarr;
    
    Node *nodeJY  = [[Node alloc] initWithNodeName:@"交易" NodeCode:@"deals"];
    ChildNode *jy1 = [[ChildNode alloc] initWithChildNodeName:@"二手交易" CNode:@"all4all"];
    ChildNode *jy2 = [[ChildNode alloc] initWithChildNodeName:@"物物交换" CNode:@"exchange"];
    ChildNode *jy3 = [[ChildNode alloc] initWithChildNodeName:@"免费赠送" CNode:@"free"];
    ChildNode *jy4 = [[ChildNode alloc] initWithChildNodeName:@"域名" CNode:@"dn"];
    ChildNode *jy5 = [[ChildNode alloc] initWithChildNodeName:@"团购" CNode:@"tuan"];
    NSArray *JYarr = @[jy1,jy2,jy3,jy4,jy5];
    nodeJY.childNodeArray = JYarr;
    
    Node *nodeCS  = [[Node alloc] initWithNodeName:@"城市" NodeCode:@"city"];
    ChildNode *cs1 = [[ChildNode alloc] initWithChildNodeName:@"北京" CNode:@"beijing"];
    ChildNode *cs2 = [[ChildNode alloc] initWithChildNodeName:@"上海" CNode:@"shanghai"];
    ChildNode *cs3 = [[ChildNode alloc] initWithChildNodeName:@"深圳" CNode:@"shenzhen"];
    ChildNode *cs4 = [[ChildNode alloc] initWithChildNodeName:@"广州" CNode:@"guangzhou"];
    ChildNode *cs5 = [[ChildNode alloc] initWithChildNodeName:@"杭州" CNode:@"hangzhou"];
    ChildNode *cs6 = [[ChildNode alloc] initWithChildNodeName:@"成都" CNode:@"chengdu"];
    ChildNode *cs7 = [[ChildNode alloc] initWithChildNodeName:@"昆明" CNode:@"kunming"];
    ChildNode *cs8 = [[ChildNode alloc] initWithChildNodeName:@"纽约" CNode:@"nyc"];
    ChildNode *cs9 = [[ChildNode alloc] initWithChildNodeName:@"洛杉矶" CNode:@"la"];
    NSArray *CSarr = @[cs1,cs2,cs3,cs4,cs5,cs6,cs7,cs8,cs9];
    nodeCS.childNodeArray = CSarr;
    
    Node *nodeWD  = [[Node alloc] initWithNodeName:@"问与答" NodeCode:@"qna"];
    ChildNode *wd1 = [[ChildNode alloc] initWithChildNodeName:@"问与答" CNode:@"qna"];
    NSArray *WDarr = @[wd1];
    nodeWD.childNodeArray = WDarr;
    
    
    Node *nodeHOT = [[Node alloc] initWithNodeName:@"最热" NodeCode:@"hot"];
    nodeHOT.childNodeArray = [NSArray new];
    
    Node *nodeALL = [[Node alloc] initWithNodeName:@"全部" NodeCode:@"all"];
    nodeALL.childNodeArray = [NSArray new];
    
    Node *nodeR2  = [[Node alloc] initWithNodeName:@"R2" NodeCode:@"r2"];
    nodeR2.childNodeArray = [NSArray new];
    
    __nodeArr = @[nodeJs,nodeCy,nodeHw,nodeAp,nodeKGZ,nodeJY,nodeCS,nodeWD,nodeHOT,nodeALL,nodeR2] ;
}

#pragma mark --- TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64.0f ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return __nodeArr.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID] ;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] ;
        cell.backgroundColor =  [UIColor colorWithRed:67/255.0 green:176/255.0 blue:248/255.0 alpha:1.0] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    
    Node *node = __nodeArr[indexPath.row] ;
    cell.textLabel.text = node.nodeName ;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f] ;
    cell.textLabel.textColor = [UIColor whiteColor] ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Node *node = __nodeArr[indexPath.row] ;
    if([self.delegate respondsToSelector:@selector(nodeSelectedCode:Name:Index:)]){
        [self.delegate nodeSelectedCode:node.nodeCode Name:node.nodeName Index:indexPath.row] ;
    }
}




@end
