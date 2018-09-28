//
//  UIColor+Extension.h
//  FHMall
//
//  Created by liruixuan on 16/4/6.
//  Copyright © 2016年 FangLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)colorWithHex:(NSInteger)hexValue Alpha:(CGFloat)alphaValue;

+ (UIColor *)colorWithHex:(NSInteger)hexValue;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString
                          alpha:(CGFloat)alpha;

+ (UIColor *)rgbColor:(CGFloat)red
                green:(CGFloat)green
                 blue:(CGFloat)blue
                alpha:(CGFloat)alpha;

+ (UIColor *)randomColor;

/**
 *  反回颜色的 RBG 格式字符串，如：#FFFFCC
 *
 *  @param color 颜色对象
 *
 *  @return 颜色字符串
 */
+ (NSString *)rgbFromColor:(UIColor *)color;


@end
