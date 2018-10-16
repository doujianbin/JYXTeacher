//
//  UITabBar+littleRedDotBadge.m
//  DocChat-C-iphone
//
//  Created by 于世民 on 2017/6/8.
//  Copyright © 2017年 juliye. All rights reserved.
//

#import "UITabBar+littleRedDotBadge.h"
#import "NSString+Size.h"
#define TabbarItemNums 4.0    //tabbar的数量

#define TabbarItemIconWidth     24
#define TabbarItemItemWidth     78.75

@implementation UITabBar (littleRedDotBadge)

//控制有数组按钮的方法
- (void)showNumBadgeOnItemIndex:(int)index Count:(int)count {
    //移除之前的小红点
    [self removeNumBadgeOnItemIndex:index];
    
    //新建数字红点
    UILabel *badgeView = [[UILabel alloc] init];
    badgeView.tag = 8888 + index;
    badgeView.backgroundColor = [UIColor redColor];
    badgeView.textColor = [UIColor whiteColor];
    if (count <= 99) {
        badgeView.text = [NSString stringWithFormat:@"%d",count];
    }else{
        badgeView.text = [NSString stringWithFormat:@"..."];
    }
    badgeView.font = [UIFont systemFontOfSize:12];
    badgeView.textAlignment = NSTextAlignmentCenter;
    CGRect tabFrame = self.frame;
    CGFloat width = [badgeView.text fittingLabelWidthWithHeight:18 andFontSize:[UIFont systemFontOfSize:12]] + 10;
    if (count < 10) {
        width = 18;
    }

    float percentX = (index + 0.56) / 3;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height) - 6;
    badgeView.frame = CGRectMake(x, y, width, 18);
    badgeView.layer.cornerRadius = 9;
    
    badgeView.clipsToBounds = YES;
    
    UIView *subView = [self viewWithTag:(888+index)];
    [self addSubview:badgeView];
    if (subView != nil) {
        [self bringSubviewToFront:badgeView];
    }
    
    if (count <= 0) {
        [self hideNumBadgeOnItemIndex:index];
    }
}

- (void)hideNumBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeNumBadgeOnItemIndex:index];
    
}

- (void)removeNumBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 8888+index) {
            [subView removeFromSuperview];
        }
    }
}

- (void)showBadgeOnItemIndex:(int)index withAllControllersCount:(int)count{
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 4;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index + 0.56) / count;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 8, 8);
    [self addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}



@end
