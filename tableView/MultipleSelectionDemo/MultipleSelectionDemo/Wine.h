//
//  Wine.h
//  MultipleSelectionDemo
//
//  Created by 杨晴贺 on 8/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wine : NSObject

/**
 *  wine 名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  wine 价格
 */
@property (nonatomic, copy) NSString *money;

/**
 *  wine 图片名称
 */
@property (nonatomic, copy) NSString *image;

/**
 *  cell 是否显示被选中, 默认不被选中
 */
@property (nonatomic, assign, getter=isChecked) BOOL checked;

@end
