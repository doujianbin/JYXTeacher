//
//  AGBaseTabBarView.m
//  ArtGrade
//
//  Created by YXG on 2018/4/20.
//  Copyright © 2018年 AG. All rights reserved.
//

#import "AGBaseTabBarView.h"
#import "AGTabBarButton.h"

@interface AGBaseTabBarView ()
@property (nonatomic, weak) AGTabBarButton *selectedButton;
@property (nonatomic, weak) UITabBarItem *tabBarItem;
@end

@implementation AGBaseTabBarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:0xffffff Alpha:0.83];
        CALayer *layer = [CALayer creatLineLayerWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)
                                                    color:[UIColor colorWithHex:0x6d6d6d Alpha:0.30]];
        [self.layer addSublayer:layer];
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    self.tabBarItem = item;
    NSNumber *customItem = item.itemCustom;
    if (customItem.boolValue) {
        
        if ([self.dataSource respondsToSelector:@selector(tabbarViewCustomViewInTabbarView:)]) {
            
            UIView *view = [self.dataSource tabbarViewCustomViewInTabbarView:self];
            [self addSubview:view];
            [self setNeedsLayout];
        }
        
    } else {
        // 1.创建按钮
        AGTabBarButton *button = [[AGTabBarButton alloc] init];
        [self addSubview:button];
        
        // 2.设置数据
        button.item = item;
        
        // 3.监听按钮点击
        [button addTarget:self action:@selector(buttonClick:)
         forControlEvents:UIControlEventTouchDown];
        
        // 4.默认选中第0个按钮
        if (self.subviews.count == 1) {
            [self buttonClick:button];
        }
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(AGTabBarButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarView:didSelectedButtonFrom:toIndex:)]) {
        
        if ([self.delegate tabBarView:self
                didSelectedButtonFrom:self.selectedButton.tag
                              toIndex:button.tag]) {
            
            // 2.设置按钮的状态
            self.selectedButton.selected = NO;
            button.selected = YES;
            self.selectedButton = button;
        }
    }
}

- (void)setButtonIndex:(NSInteger)index
{
    if (index > self.subviews.count) return;
    AGTabBarButton *button = self.subviews[index];
    [self buttonClick:button];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 按钮的frame数据
    CGFloat buttonH = self.frame.size.height-kAddBottomHeight;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.subviews.count; index++) {
        
        CGFloat buttonX = index * buttonW;
        // 1.取出按钮
        UIView *button = self.subviews[index];
        // 2.绑定tag
        button.tag = index;
        
        // 3.设置按钮的frame
        if ([button isMemberOfClass:[[self.dataSource tabbarViewCustomViewInTabbarView:self] class]]) {
            
            UIView *view = [self.dataSource tabbarViewCustomViewInTabbarView:self];
            button.frame = CGRectMake(buttonX, buttonH - view.height,
                                      buttonW, view.height);
        } else {
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        }
    }
}

@end
