//
//  UIBarButtonItem+Extension.h
//  FHMall
//
//  Created by liruixuan on 16/4/25.
//  Copyright © 2016年 FangLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)microShopitemWithTitle:(NSString *)buttonTitle
                                     action:(SEL)action
                                 titleColor:(UIColor *)titleColor
                                 buttonFont:(UIFont *)buttonFont
                                     target:(id)target;

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(NSString *)image
                          highImage:(NSString *)highImage;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)buttonTitle
                            action:(SEL)action
                        titleColor:(UIColor *)titleColor
                        buttonFont:(UIFont *)buttonFont
                            target:(id)target;
/**
 *  导航条右边更多按钮
 */
+ (UIBarButtonItem *)createRightItemWithTarget:(id)target
                                        action:(SEL)action
                                         image:(NSString *)image
                                     highImage:(NSString *)highImage
                                         title:(NSString *)title;


@end
