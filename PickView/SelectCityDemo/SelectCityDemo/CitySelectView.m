//
//  CitySelectView.m
//  SelectCityDemo
//
//  Created by 杨晴贺 on 15/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CitySelectView.h"

@interface CitySelectView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIView *_contentView ;   // 容器
    NSArray *_dataArray ;   // 数据源
    NSMutableArray *_provinceArray ; // 装省份数据
    NSMutableArray *_cityArray ;  // 装城市数据
    NSMutableArray *_disArray ;  //装区的数据
    UIPickerView *_pickView ;  // 选择器
    
    NSInteger _proIndex ;  // 选择省份的索引
    NSInteger _cityIndex ;  // 选择城市的索引
    NSInteger _disIndex ;  // 选择区的索引
}

@property (nonatomic,copy) ClickBlock clickBlock ;

@end

@implementation CitySelectView

#pragma mark --- init
- (instancetype)initWithFrame:(CGRect)frame withSelectCityTitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        _provinceArray = [NSMutableArray array] ;
        _cityArray = [NSMutableArray array] ;
        _disArray = [NSMutableArray array] ;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0] ;
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3] ;
        }] ;
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Address" ofType:@"plist"] ;
        _dataArray = [NSArray arrayWithContentsOfFile:path] ;
        NSLog(@"%@",_dataArray) ;
        for(NSDictionary *dic in _dataArray){
            [_provinceArray addObject:[[dic allKeys]firstObject]] ;
        }
        if (!_provinceArray.count) {
            NSLog(@"数据初始化失败") ;
        }
        
        // 显示PickView和按钮最下面的View
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 260)] ;
        [self addSubview:_contentView] ;
        
        UIView *tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)] ;
        tool.backgroundColor = [UIColor colorWithRed:61/255.0 green:67/255.0 blue:79/255.0 alpha:1.0] ;
        
        // 按钮和中间显示的标题内容
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
        cancel.frame = CGRectMake(0, 0, 60, 40) ;
        [cancel setTitle:@"取消" forState:UIControlStateNormal] ;
        [cancel addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside] ;
        [tool addSubview:cancel] ;
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(cancel.frame.size.width, 0, self.frame.size.width - 120, 40)] ;
        titleLabel.text = title ;
        titleLabel.textColor = [UIColor blackColor] ;
        titleLabel.textAlignment = NSTextAlignmentCenter ;
        [tool addSubview:titleLabel] ;
       
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
        confirmBtn.frame = CGRectMake(self.frame.size.width-60., 0, 60, 40) ;
        [confirmBtn setTitle:@"选择" forState:UIControlStateNormal] ;
        [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside] ;
        [tool addSubview:confirmBtn] ;
        [_contentView addSubview:tool] ;
        
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, _contentView.frame.size.height-40)] ;
        _pickView.delegate = self ;
        _pickView.dataSource = self ;
        _pickView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0] ;
        [_contentView addSubview:_pickView] ;
        
        for(NSDictionary *dic in _dataArray){
            if([dic objectForKey:_provinceArray[_proIndex]]){
                _cityArray = [NSMutableArray arrayWithArray:[[dic objectForKey:_provinceArray[_proIndex]] allKeys]] ;
                [_pickView reloadComponent:1] ;
                [_pickView selectRow:0 inComponent:1 animated:YES] ;
                
                _disArray = [NSMutableArray arrayWithArray:[[dic objectForKey:_provinceArray[_proIndex]] objectForKey:_cityArray[0]]];
                [_pickView reloadComponent:2] ;
                [_pickView selectRow:0 inComponent:2 animated:YES] ;
            }
        }
        
    }
    return self ;
}


#pragma mark --- delegate 
// 自定义每个pickView的View
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickLabel = [[UILabel alloc]init] ;
    pickLabel.numberOfLines = 0 ;
    pickLabel.textAlignment = NSTextAlignmentCenter ;
    [pickLabel setFont:[UIFont systemFontOfSize:12]] ;
    pickLabel.text =  [self pickerView:pickerView titleForRow:row forComponent:component] ;
    return pickLabel ;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _proIndex = row ;
        _cityIndex = 0 ;
        _disIndex = 0 ;
        for(NSDictionary *dic in _dataArray){
            if([dic objectForKey:_provinceArray[_proIndex]]){
                _cityArray = [NSMutableArray arrayWithArray:[[dic objectForKey:_provinceArray[_proIndex]] allKeys]] ;
                [_pickView reloadComponent:1] ;
                [_pickView selectRow:0 inComponent:1 animated:YES] ;
                
                _disArray = [NSMutableArray arrayWithArray:[[dic objectForKey:_provinceArray[_proIndex]] objectForKey:_cityArray[0]]];
                [_pickView reloadComponent:2] ;
                [_pickView selectRow:0 inComponent:2 animated:YES] ;
            }
        }
    }
    
    if(component == 1){
        _cityIndex = row ;
        for(NSDictionary *dic in _dataArray){
            if ([dic objectForKey:_provinceArray[_proIndex]]) {
                _disArray = [[dic objectForKey:_provinceArray[_proIndex]] objectForKey:_cityArray[_cityIndex]];
                [_pickView reloadComponent:2];
                [_pickView selectRow:0 inComponent:2 animated:YES];
            }
        }
    }
    
    if(component == 2){
        _disIndex = row ;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3 ;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return _provinceArray.count ;
    }
    
    if (component == 1) {
        return _cityArray.count ;
    }
    
    if(component == 2){
        return _disArray.count ;
    }
    
    return  0 ;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return [_provinceArray objectAtIndex:row] ;
    }
    
    if (component == 1) {
        return [_cityArray objectAtIndex:row] ;
    }
    
    if(component == 2){
        return [_disArray objectAtIndex:row] ;
    }
    
    return nil ;
}

#pragma mark  --- Public Method
- (void)showCityView:(ClickBlock)clickBlock{
    self.clickBlock = clickBlock;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    __weak typeof (UIView *)blockView = _contentView;
    __block int blockH = self.frame.size.height;
    __block int bjH = 260 ;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect BJf = blockView.frame;
        BJf.origin.y = blockH - bjH;
        blockView.frame = BJf;
    }];
}

#pragma mark --- Action
- (void)cancelBtnClick{
    __weak typeof (UIView *)blockView = _contentView;
    __weak typeof(self)blockself = self;
    __block int blockH = self.frame.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect BJf = blockView.frame;
        BJf.origin.y = blockH;
        blockView.frame = BJf;
        blockself.alpha = 0.1;
    }completion:^(BOOL finished) {
        [blockself removeFromSuperview];
    }];
}

- (void)confirmBtnClick{
    __weak typeof (UIView *)blockView = _contentView;
    __weak typeof(self)blockself = self;
    __block int blockH = self.frame.size.height;
    
    if (self.clickBlock) {
        self.clickBlock(_provinceArray[_proIndex],_cityArray[_cityIndex],_disArray[_disIndex]);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect BJf = blockView.frame;
        BJf.origin.y = blockH;
        blockView.frame = BJf;
        blockself.alpha = 0.1;
    }completion:^(BOOL finished) {
        [blockself removeFromSuperview];
    }];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(_contentView.frame, point)) {
        [self cancelBtnClick];
    }
}

@end
