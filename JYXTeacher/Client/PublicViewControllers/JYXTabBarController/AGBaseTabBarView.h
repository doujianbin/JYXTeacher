//
//  AGBaseTabBarView.h
//  ArtGrade
//
//  Created by YXG on 2018/4/20.
//  Copyright © 2018年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGBaseTabBarView;

@protocol BaseTabbarViewDataSource <NSObject>

@optional

/**
 设置自定义的view加入到tabbatview:需配合itemCustom属性使用，
 itemCustom: NSNumber类型，存放BOOL值，意思为是否使用自定义view
 自定义view不参与tabbar点击事件请自己实现
 
 @param tabbarView tabbar
 @return 自定义view
 */
- (UIView *)tabbarViewCustomViewInTabbarView:(AGBaseTabBarView *)tabbarView;

@end

@protocol BaseTabBarViewDelegate <NSObject>

@optional
- (BOOL)tabBarView:(AGBaseTabBarView *)tabBar didSelectedButtonFrom:(NSInteger)from toIndex:(NSInteger)index;

@end

@interface AGBaseTabBarView : UIView
@property (nonatomic, weak) id <BaseTabbarViewDataSource> dataSource;
@property (nonatomic, weak) id <BaseTabBarViewDelegate> delegate;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
- (void)setButtonIndex:(NSInteger)index;

@end
