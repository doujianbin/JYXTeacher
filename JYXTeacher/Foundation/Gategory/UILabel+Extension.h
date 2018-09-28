//
//  UILabel+Extension.h
//  FHMall
//
//  Created by liruixuan on 16/3/15.
//  Copyright © 2016年 FangLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

+ (UILabel*)labelWithFrame:(CGRect)frame
                      text:(NSString*)text
                 textColor:(UIColor*)textColor
                  textFont:(UIFont*)textFont
                       tag:(NSInteger)tag;

+ (UILabel *)labelWithText:(NSString *)text
               colorString:(NSString *)colorStr
                  textFont:(UIFont*)textFont
             textAlignment:(NSTextAlignment)textAlignment;

@end
