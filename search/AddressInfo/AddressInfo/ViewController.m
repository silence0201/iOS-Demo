//
//  ViewController.m
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "CitySelectViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)selectAction:(id)sender {
    CitySelectViewController *vc=[[CitySelectViewController alloc]init];
    typeof(self) __weak weakSelf = self ;
    [vc returnText:^(NSString *cityname) {
        weakSelf.cityLabel.text=cityname;
    }];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
