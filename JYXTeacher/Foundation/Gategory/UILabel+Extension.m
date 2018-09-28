//
//  UILabel+Extension.m
//  FHMall
//
//  Created by liruixuan on 16/3/15.
//  Copyright © 2016年 FangLin. All rights reserved.
//

#import "UILabel+Extension.h"
#import "UIColor+Extension.h"

@implementation UILabel (Extension)

+ (UILabel*)labelWithFrame:(CGRect)frame
                      text:(NSString*)text
                 textColor:(UIColor*)textColor
                  textFont:(UIFont*)textFont
                       tag:(NSInteger)tag{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.tag = tag;
    label.text = text;
    label.textColor = textColor;
    label.font = textFont;
//    label.numberOfLines = 0;
//    label.textAlignment = NSTextAlignmentCenter;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    return label;
}


+ (UILabel *)labelWithText:(NSString *)text
               colorString:(NSString *)colorStr
                  textFont:(UIFont*)textFont
             textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textColor = [UIColor colorWithHexString:colorStr];
    label.font = textFont;
    label.textAlignment = textAlignment;
    return label;
}

@end
