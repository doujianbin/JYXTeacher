//
//
//  NSDictionary+MYAddition.h
//  MiYaBaoBei
//
//  Created by ZuoPengHui on
//  Copyright (c) 2017年 ZuoPengHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MYAddition)

/*!
 @method objectAtIndexCheck:
 @abstract 检查是否越界和NSNull如果是返回nil
 @result 返回对象
*/
- (id)objectAtIndexCheck:(NSUInteger)index;


/**
 把一个数组拆分成多个数组，
 subSize必须为数组的倍数

 @param array 需要拆分的数组
 @param subSize 拆分后的数组的长度
 @return 包含多个数组的数据
 */
+ (NSArray *)splitArray:(NSArray *)array withSubSize:(int)subSize;

@end
