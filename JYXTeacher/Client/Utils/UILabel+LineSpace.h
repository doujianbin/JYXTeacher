//
//  UILabel+LineSpace.h
//  juliye-C-iphone
//
//  Created by lixiao on 16/8/17.
//  Copyright © 2016年 juliye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LineSpace)

- (void)setSpaceLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width;

- (void)setSpaceLabelHeightWithText:(NSString*)str_text Color:(UIColor *)color;

- (CGFloat)getSpaceHeightWithText:(NSString*)str_text withWidth:(CGFloat)width;
- (CGFloat)getSpaceLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width;

- (CGFloat)getSpaceLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width withFont:(UIFont *)font withRange:(NSRange)range;

- (void)setSpaceJustifiedLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width;

- (CGFloat)getSpaceJustifiedLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width;

- (void)setSpaceJustifiedHTMLLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width;
- (CGFloat)getSpaceJustifiedHTMLLabelHeightWithText:(NSString*)str_text withWidth:(CGFloat)width;

//获得行数和行内容
+ (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label;

-(NSArray *)getSeparatedLinesFromLabel;

-(void)alignTop;

-(void)alignBottom;

+ (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font;

@end
