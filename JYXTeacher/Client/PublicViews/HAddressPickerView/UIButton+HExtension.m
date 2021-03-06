//
//  UIButton+HExtension.m
//  WeLearn
//
//  Created by YXG on 2018/1/11.
//  Copyright © 2018年 WeLearn. All rights reserved.
//

#import "UIButton+HExtension.h"

@implementation UIButton (HExtension)
+ (UIButton *)h_buttonWithTarget:(id)target action:(SEL)action frame:(CGRect)frame imageName:(NSString *)imageName titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor title:(NSString *)title {
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = frame;
    button.backgroundColor = backgroundColor;
    
    if (title.length) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        
    }
    if (titleFont) {
        button.titleLabel.font = titleFont;
    }
    
    if (imageName.length) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        if (title.length) {
            
            button.titleEdgeInsets = UIEdgeInsetsMake(0, H_ScaleWidth(10), 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, H_ScaleWidth(10));
        }
    }
    
    if (cornerRadius > 0) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = cornerRadius;
    }
    button.layer.borderWidth = borderWidth;
    button.layer.borderColor = borderColor.CGColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)h_buttonWithTarget:(id)target action:(SEL)action frame:(CGRect)frame imageName:(NSString *)imageName titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor title:(NSString *)title {
    return [UIButton h_buttonWithTarget:target action:action frame:frame imageName:imageName titleColor:titleColor titleFont:titleFont backgroundColor:backgroundColor cornerRadius:0 borderWidth:0 borderColor:nil title:title];
}

+ (UIButton *)h_buttonWithTarget:(id)target action:(SEL)action frame:(CGRect)frame imageName:(NSString *)imageName titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont title:(NSString *)title {
    return [UIButton h_buttonWithTarget:target action:action frame:frame imageName:imageName titleColor:titleColor titleFont:titleFont backgroundColor:nil cornerRadius:0 borderWidth:0 borderColor:nil title:title];
}

+ (UIButton *)h_buttonWithTarget:(id)target action:(SEL)action frame:(CGRect)frame titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont title:(NSString *)title {
    return [UIButton h_buttonWithTarget:target action:action frame:frame imageName:nil titleColor:titleColor titleFont:titleFont backgroundColor:nil cornerRadius:0 borderWidth:0 borderColor:nil title:title];
}

+ (UIButton *)h_buttonWithTarget:(id)target action:(SEL)action frame:(CGRect)frame titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor title:(NSString *)title {
    return [UIButton h_buttonWithTarget:target action:action frame:frame imageName:nil titleColor:titleColor titleFont:titleFont backgroundColor:backgroundColor cornerRadius:0 borderWidth:0 borderColor:nil title:title];
}

+ (UIButton *)h_buttonWithTarget:(id)target action:(SEL)action frame:(CGRect)frame imageName:(NSString *)imageName cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [UIButton h_buttonWithTarget:target action:action frame:frame imageName:imageName titleColor:nil titleFont:0 backgroundColor:nil cornerRadius:cornerRadius borderWidth:borderWidth borderColor:borderColor title:nil];
}

+ (UIButton *)h_buttonWithTarget:(id)target action:(SEL)action frame:(CGRect)frame imageName:(NSString *)imageName {
    return [UIButton h_buttonWithTarget:target action:action frame:frame imageName:imageName titleColor:nil titleFont:0 backgroundColor:nil cornerRadius:0 borderWidth:0 borderColor:nil title:nil];
}
@end
