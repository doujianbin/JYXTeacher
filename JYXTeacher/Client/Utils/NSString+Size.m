//
//  NSString+Size.m
//  zlycare-iphone
//
//  Created by Ryan on 14-8-5.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)contentSize
{
    if (self && ![self isEqualToString:@""]) {
        return [self boundingRectWithSize:CGSizeMake(270, 90) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:FONT_SIZE_DESC]} context:nil].size;
    }else{
        return CGSizeZero;
    }
}

- (CGFloat)fittingLabelHeightWithWidth:(CGFloat)width andFontSize:(UIFont *)font
{
    if (self && ![self isEqualToString:@""]) {
        return [self boundingRectWithSize:CGSizeMake(width, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height + 2;
    }else{
        return 0;
    }
}

- (CGFloat)fittingLabelWidthWithHeight:(CGFloat)height andFontSize:(UIFont *)font
{
    if (self && ![self isEqualToString:@""]) {
        return [self boundingRectWithSize:CGSizeMake(0, height) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width + 2;
    }else{
        return 0;
    }

}

//计算UILabel的高度(带有行间距的情况)
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 5;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
//根据字体取大小
+ (CGSize)sizeOfString:(NSString *)string{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
}

+ (CGSize)sizeOfString:(NSString *)string WithFont:(CGFloat)font{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
}
@end
