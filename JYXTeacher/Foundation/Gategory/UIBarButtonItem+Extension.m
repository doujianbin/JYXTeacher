//
//  UIBarButtonItem+Extension.m
//  FHMall
//
//  Created by liruixuan on 16/4/25.
//  Copyright © 2016年 FangLin. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 *  创建一个图片item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(NSString *)image
                          highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (highImage) {
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 设置尺寸
    btn.size = CGSizeMake(40, 40);
    // 把UIButton包装成UIBarButtonItem 有会按钮点击范围过大的问题
    // 解决这个问题
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containView];
    return item;
}

+ (UIBarButtonItem *)microShopitemWithTitle:(NSString *)buttonTitle
                                     action:(SEL)action
                                 titleColor:(UIColor *)titleColor
                                 buttonFont:(UIFont *)buttonFont
                                     target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    btn.titleLabel.font = buttonFont;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.size = CGSizeMake(24, 24);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)buttonTitle
                            action:(SEL)action
                        titleColor:(UIColor *)titleColor
                        buttonFont:(UIFont *)buttonFont
                            target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    btn.titleLabel.font = buttonFont;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.size = CGSizeMake(50, 40);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  more更多按钮的创建
 */
+ (UIBarButtonItem *)createRightItemWithTarget:(id)target
                                        action:(SEL)action
                                         image:(NSString *)image
                                     highImage:(NSString *)highImage
                                         title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

















@end
