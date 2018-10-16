//
//  UITabBar+littleRedDotBadge.h
//  DocChat-C-iphone
//
//  Created by 于世民 on 2017/6/8.
//  Copyright © 2017年 juliye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (littleRedDotBadge)

- (void)showNumBadgeOnItemIndex:(int)index Count:(int)count; //显示带数字的小红点

- (void)hideNumBadgeOnItemIndex:(int)index;  //隐藏带数字的小红点

- (void)showBadgeOnItemIndex:(int)index withAllControllersCount:(int)count; //显示正常小红点
- (void)hideBadgeOnItemIndex:(int)index; //隐藏正常小红点
@end
