//
//  ShopCartCell.m
//  ShopCartDemo
//
//  Created by 杨晴贺 on 08/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ShopCartCell.h"
#import "UIView+Frame.h"
#import "LineLabel.h"
#import "NumberView.h"



@interface ShopCartCell ()<NumberViewDelegate>

@property (nonatomic,strong) UIImageView *checkImageView ;
@property (nonatomic,strong) UIImageView *shopImageView ;
@property (nonatomic,strong) UILabel *shopNameLabel ;
@property (nonatomic,strong) UILabel *priceLabel ;
@property (nonatomic,strong) LineLabel *oldPriceLabel ;  // 原价
@property (nonatomic,strong) UILabel *shopTypeLabel ; // 商品的类型
@property (nonatomic,strong) UIButton *reduceBtn ;   // 减数量按钮
@property (nonatomic,strong) UIButton *addBtn ;   // 加数量按钮
@property (nonatomic,strong) UILabel *numberLabel ;   // 显示数量
@property (nonatomic,assign) BOOL selectStatus ;   // 选中的状态
@property (nonatomic,strong) NumberView *numberView ;

@end

@implementation ShopCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews] ;
    }
    return self ;
}

- (void)setupSubViews{
    self.checkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (110-20)/2.0, 20, 20)] ;
    self.checkImageView.image = [UIImage imageNamed:@"check_p"] ;
    [self addSubview:self.checkImageView] ;
    
    self.shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.checkImageView.right+10, 15, 60, 60)] ;
    self.shopImageView.image = [UIImage imageNamed:@"img"] ;
    [self addSubview:self.shopImageView] ;
    
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-90, (110-20)/2.0-20, 80, 20)];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.text = @"￥123.00";
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.priceLabel];
    
    self.oldPriceLabel = [[LineLabel alloc]initWithFrame:CGRectMake(kScreenWidth-70,self.priceLabel.bottom+5, 58, 14)];
    self.oldPriceLabel.textColor = [UIColor grayColor];
    self.oldPriceLabel.text = @"￥200.00";
    self.oldPriceLabel.backgroundColor = [UIColor clearColor];
    self.oldPriceLabel.textAlignment = NSTextAlignmentRight;
    self.oldPriceLabel.font = [UIFont systemFontOfSize:13] ;
    [self addSubview:self.oldPriceLabel];
    
    self.shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right+10,self.shopImageView.top-5,kScreenWidth-self.shopImageView.right-20-self.priceLabel.width, 20)];
    self.shopNameLabel.text = @"合生元金装3段1-3岁";
    self.shopNameLabel.numberOfLines = 0 ;
    self.shopNameLabel.font = [UIFont systemFontOfSize:16] ;
    [self addSubview:self.shopNameLabel] ;
    
    self.shopTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.shopNameLabel.left,self.shopNameLabel.bottom,self.shopNameLabel.width, 20)];
    self.shopTypeLabel.text = @"通用型号";
    self.shopTypeLabel.textColor = [UIColor darkGrayColor];
    self.shopTypeLabel.font = [UIFont systemFontOfSize:12] ;
    [self addSubview:self.shopTypeLabel];
    
    UILabel *numberTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopTypeLabel.left,self.shopImageView.bottom-5,35, 16)];
    numberTitleLab.text = @"数量:";
    numberTitleLab.textColor = [UIColor darkGrayColor];
    numberTitleLab.font = [UIFont systemFontOfSize:12] ;
    [self addSubview:numberTitleLab];
    
    
    self.numberView = [[NumberView alloc]initWithFrame:CGRectMake(numberTitleLab.right+5, numberTitleLab.top-2, 93, 22)];
    self.numberView.delegate = self;
    self.numberView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.numberView];
}

- (void)setShopModel:(ShopModel *)shopModel{
    _shopModel = shopModel ;
    
    if(shopModel.selectState){
        self.checkImageView.image = [UIImage imageNamed:@"check_p"] ;
        self.selectStatus = YES ;
    }else{
        self.selectStatus = NO ;
        self.checkImageView.image = [UIImage imageNamed:@"check_n"] ;
    }
    
    self.shopTypeLabel.text = shopModel.goodType ;
    self.priceLabel.text = shopModel.goodPrice ;
    self.shopNameLabel.text = shopModel.goodTitle ;
    self.oldPriceLabel.text = shopModel.oldGoodPrice ;
    self.numberView.numberStr = [NSString stringWithFormat:@"%ld",shopModel.goodCount];
 }

#pragma mark ---- delegate
- (void)numberView:(NumberView *)numberView addAction:(UIButton *)button{
    if (self.selectStatus == YES) {
        if ([self.delegate respondsToSelector:@selector(btnClick:addFlag:)]) {
            [self.delegate btnClick:self addFlag:button.tag] ;
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没选中你加什么" delegate:self cancelButtonTitle:@"好吧" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)numberView:(NumberView *)numberView reductAction:(UIButton *)button{
    if (self.selectStatus == YES) {
        if ([self.delegate respondsToSelector:@selector(btnClick:addFlag:)]) {
            [self.delegate btnClick:self addFlag:button.tag] ;
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没选中你加什么" delegate:self cancelButtonTitle:@"好吧" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
