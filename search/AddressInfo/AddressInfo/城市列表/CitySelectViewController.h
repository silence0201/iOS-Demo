//
//  CitySelectViewController.h
//  AddressInfo
//
//  Created by 杨晴贺 on 17/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnCityName)(NSString *cityname);
@interface CitySelectViewController : UIViewController

@property (nonatomic,copy) ReturnCityName returnBlock ;

- (void)returnText:(ReturnCityName)block ;

@end
