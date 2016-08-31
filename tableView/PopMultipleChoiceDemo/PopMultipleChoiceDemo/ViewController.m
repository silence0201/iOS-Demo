//
//  ViewController.m
//  PopMultipleChoiceDemo
//
//  Created by 杨晴贺 on 8/31/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "TableViewContaint.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic,strong) NSArray *backArray ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)choice:(UIButton *)sender {
    NSArray *dataArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21", nil];
    TableViewContaint *view = [[TableViewContaint alloc]initWithData:dataArray andConfireBlock:^(NSString *confire, NSArray *backArray) {
        self.resultLabel.text = confire ;
        self.backArray = backArray ;
        NSLog(@"%@",backArray) ;
    } andCancelBlock:^{
        
    }] ;
    view.selectArray = _backArray ;
}

- (NSArray *)backArray{
    if (_backArray == nil) {
        _backArray = [NSArray array] ;
    }
    return _backArray ;
}



@end
