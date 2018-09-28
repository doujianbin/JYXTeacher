//
//  AGBaseTabBarController.h
//  ArtGrade
//
//  Created by YXG on 2018/4/20.
//  Copyright © 2018年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGBaseTabBarView;

@interface AGBaseTabBarController : UITabBarController
/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers;

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 *  @param hasNavigation     是否使用导航控制器
 */
- (void)setupChildViewController:(UIViewController *)childVc
                           title:(NSString *)title
                       imageName:(NSString *)imageName
               selectedImageName:(NSString *)selectedImageName
                   hasNavigation:(BOOL)hasNavigation;

/** 手动设置tabbar的index */
- (void)setTabBarIndex:(NSInteger)index;

/**
 点击的导航index
 
 @param from 从哪个index点击的
 @param index 点击了哪一个index
 */
- (void)didSelectedButtonFrom:(NSInteger)from toIndex:(NSInteger)index;

/** 拦截当前点击的tabbarItem是否可以切换到指定页面  提供子类重写，默认YES */
- (BOOL)shouldSelectViewControllerFromIndex:(NSInteger)index;

- (UIView *)tabbarViewCustomViewInTabbarView:(AGBaseTabBarView *)tabbatView;

@end

@interface UIViewController (baseTabBarVC)

/** 当前tabBar导航 */
@property (nonatomic, readonly) AGBaseTabBarController *customTabBarVC;

@end
