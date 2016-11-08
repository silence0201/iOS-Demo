//
//  ViewController.m
//  ShopCartDemo
//
//  Created by 杨晴贺 on 08/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "ShopModel.h"
#import "ShopCartCell.h"

#define DesignHeight 1334.0
#define DesignWidth 750.0
#define GetWidth(width)  (width)/DesignWidth*kScreenWidth
#define GetHeight(height) (kScreenHeight > 568 ? (height)/DesignHeight*kScreenHeight : (height)/DesignHeight*568)
#define RGBACOLOR(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ShopCartCellDelegate>

@property (nonatomic,strong) UITableView *tableView ;
@property (nonatomic,strong) NSMutableArray *dataArray ;
@property (nonatomic,strong) UIButton *selectAllButton ;  //全选按钮
@property (nonatomic,strong) UIButton *countButton ;  // 结算按钮
@property (nonatomic,strong) UILabel *totalMoneyLabel ;  // 总金额
@property (nonatomic,assign) CGFloat allPrice ;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车" ;
    
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor] ;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.allPrice = 0.00;
    [self initData] ;
    [self setupSubViews] ;
    
}


- (void)setupSubViews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , kScreenWidth, kScreenHeight-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView] ;
    
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:self.tableView.bounds] ;
    bgImage.image = [UIImage imageNamed:@"bg"] ;
    bgImage.contentMode = UIViewContentModeScaleAspectFill ;
    UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]] ;
    visualEfView.frame = bgImage.bounds ;
    visualEfView.alpha = 0.6 ;
    [bgImage addSubview:visualEfView] ;
    self.tableView.backgroundView = bgImage ;
    
    self.selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllButton.frame = CGRectMake(10,self.tableView.bottom+(50-20)/2.0, 60, 20);
    [self.selectAllButton setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [self.selectAllButton setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
    [self.selectAllButton addTarget:self action:@selector(selectAllAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectAllButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectAllButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.selectAllButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:self.selectAllButton];
    
    self.totalMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.selectAllButton.right+10, self.selectAllButton.top, kScreenWidth-self.selectAllButton.right-30-GetWidth(184),20)];
    
    self.totalMoneyLabel.textAlignment = NSTextAlignmentCenter;
    self.totalMoneyLabel.font = [UIFont systemFontOfSize:13];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLabel.attributedText = str;
    [self.view addSubview:self.totalMoneyLabel];
    
    self.countButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.countButton.frame = CGRectMake(kScreenWidth-GetWidth(184)-10,self.tableView.bottom+(50-GetHeight(74))/2.0,GetWidth(184), GetHeight(74));
    [self.countButton setBackgroundColor:RGBACOLOR(0, 189, 155, 1)];
    [self.countButton addTarget:self action:@selector(countAction:) forControlEvents:UIControlEventTouchUpInside];
    self.countButton.layer.masksToBounds = YES;
    self.countButton.layer.cornerRadius = GetHeight(74)/2.0;
    [self.countButton setTitle:@"结算" forState:UIControlStateNormal];
    
    [self.countButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.countButton.titleLabel.font = [UIFont systemFontOfSize:15] ;
    self.countButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:self.countButton];
}

- (void)initData{
    for(NSInteger i= 0 ; i<10;i++){
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
        [infoDict setValue:@"img.png" forKey:@"imageName"];
        [infoDict setValue:[NSString stringWithFormat:@"Apple:%ld",i] forKey:@"goodTitle"];
        [infoDict setValue:@"我是详细介绍" forKey:@"goodType"];
        [infoDict setValue:@"50.00" forKey:@"goodPrice"];
        [infoDict setValue:@"1000.00" forKey:@"oldGoodPrice"] ;
        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
        [infoDict setValue:[NSNumber numberWithInt:1] forKey:@"goodCount"];
        
        ShopModel *goodModel = [ShopModel shopWithDic:infoDict] ;
        [self.dataArray addObject:goodModel];
    }
    
}

- (void)selectAllAction:(UIButton *)button{
    button.tag = !button.tag;
    if (button.tag){
        button.selected = YES;
    }else{
        button.selected = NO;
    }
    //改变单元格选中状态
    for (int i=0; i<self.dataArray.count;i++){
        ShopModel *model = self.dataArray[i];
        model.selectState = button.tag;
    }
    
    [self CalculationPrice];
    
    [self.tableView reloadData];
}

- (void)countAction:(UIButton *)button{
    NSLog(@"结算") ;
}

//计算价格
-(void)CalculationPrice{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格(单价 * 商品数量)
    for ( int i =0; i<self.dataArray.count;i++){
        ShopModel *model = self.dataArray[i];
        if (model.selectState){
            self.allPrice = self.allPrice + model.goodCount *[model.goodPrice floatValue];
        }
    }
    //给总价赋值
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLabel.attributedText = str;
    
    self.allPrice = 0.0;
}

/**
 * 实现加减按钮点击代理事件
 *
 * @param cell 当前单元格
 * @param flag 按钮标识，11 为减按钮，12为加按钮
 */



-(void)btnClick:(UITableViewCell *)cell addFlag:(NSInteger)flag{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    switch (flag) {
        case 101:{
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            ShopModel *model = self.dataArray[index.row];
            if (model.goodCount > 1){
                model.goodCount --;
            }
        }
            break;
        case 102:{
            //做加法
            ShopModel *model = self.dataArray[index.row];
            model.goodCount ++;
        }
            break;
        default:
            break;
    }
    //刷新表格
    [self.tableView reloadData];
    //计算总价
    [self CalculationPrice];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"ShopCartCell";
    
    ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if(!cell){
        cell = [[ShopCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.delegate = self;
    cell.shopModel = self.dataArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor] ;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}



//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     * 判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    ShopModel *model = self.dataArray[indexPath.row];
    if (model.selectState){
        model.selectState = NO;
    }else{
        model.selectState = YES;
    }
    
    //刷新当前行
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self CalculationPrice];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array] ;
    }
    return _dataArray ;
}





@end
