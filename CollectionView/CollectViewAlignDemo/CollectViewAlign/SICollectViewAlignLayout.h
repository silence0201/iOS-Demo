//
//  SICollectViewAlignLayout.h
//  CollectViewAlignDemo
//
//  Created by 杨晴贺 on 09/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SICollectViewAlign) {
    SICollectViewAlignRight,
    SICollectViewAlignCenter,
    SICollectViewAlignLeft
};

@interface SICollectViewAlignLayout : UICollectionViewFlowLayout

- (instancetype)initWithAlignType:(SICollectViewAlign)type ;

@end
