//
//  NSString+Size.h
//  zlycare-iphone
//
//  Created by Ryan on 14-8-5.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

- (CGSize)contentSize;

- (CGFloat)fittingLabelHeightWithWidth:(CGFloat)width andFontSize:(UIFont *)font;

- (CGFloat)fittingLabelWidthWithHeight:(CGFloat)height andFontSize:(UIFont *)font;

+ (CGSize)sizeOfString:(NSString *)string;

+ (CGSize)sizeOfString:(NSString *)string WithFont:(CGFloat)font;

//计算UILabel的高度(带有行间距的情况)
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;

@end
