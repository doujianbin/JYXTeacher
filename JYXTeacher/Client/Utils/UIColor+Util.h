//
//  UIColor+Util.h
//  imgb
//
//  Created by kimziv on 13-12-17.
//  Copyright (c) 2013年 bitbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)

//获得这个颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color;
//根据颜色码取得颜色对象
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
