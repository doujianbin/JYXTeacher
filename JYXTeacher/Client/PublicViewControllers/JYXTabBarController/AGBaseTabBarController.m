//
//  AGBaseTabBarController.m
//  ArtGrade
//
//  Created by YXG on 2018/4/20.
//  Copyright © 2018年 AG. All rights reserved.
//

#import "AGBaseTabBarController.h"
#import "AGBaseTabBarView.h"

static AGBaseTabBarController *customTabBarVC;

@implementation UIViewController (baseTabBarVC)

- (AGBaseTabBarController *)customTabBarVC
{
    return customTabBarVC;
}

@end

@interface AGBaseTabBarController ()<BaseTabBarViewDelegate, BaseTabbarViewDataSource,
UITabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, weak) AGBaseTabBarView *customTabBar;

@end

@implementation AGBaseTabBarController
#pragma mark - lifeCycle                    - Method -

- (void)dealloc
{
    NSLog(@"%@ -------> %@", NSStringFromSelector(_cmd), NSStringFromClass([self class]));
}

- (void)loadView
{
    [super loadView];
    
    [self setupTabbar];
    [self setupAllChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabBar setTranslucent:NO];
    customTabBarVC = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    
    AGBaseTabBarView *customTabBar = [[AGBaseTabBarView alloc] init];
    CGRect frame = self.tabBar.frame;
    frame.size.height = kTabBarHeight;
    self.tabBar.frame = frame;
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    customTabBar.dataSource = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
    [self.tabBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]
                                                   size:CGSizeMake(1.0, 1.0)]];
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
}

/**
 *  初始化所有的子控制器。供子类重写
 */
- (void)setupAllChildViewControllers
{
    
}

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
                   hasNavigation:(BOOL)hasNavigation
{
    if (!childVc) {
        return;
    }
    
    if (title.isNotBlank) {
        // 1.设置控制器的属性
        childVc.title = title;
    }
    
    if (imageName.isNotBlank) {
        // 设置图标
        childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    }
    
    if (selectedImageName.isNotBlank) {
        // 设置选中的图标
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } else {
            childVc.tabBarItem.selectedImage = selectedImage;
        }
    }
    
    if (hasNavigation) {
        // 2.包装一个导航控制器
        JYXBaseNavigationController *nav = [[JYXBaseNavigationController alloc] initWithRootViewController:childVc];
        [self addChildViewController:nav];
    }
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

- (BOOL)shouldSelectViewControllerFromIndex:(NSInteger)index
{
    return YES;
}

#pragma mark - eventResponse                - Method -

- (void)setTabBarIndex:(NSInteger)index
{
    if (index > self.customTabBar.subviews.count) return;
    [self.customTabBar setButtonIndex:index];
}

- (void)didSelectedButtonFrom:(NSInteger)from toIndex:(NSInteger)index
{
    
}

#pragma mark - BaseTabBarViewDelegate               - Method -

- (BOOL)tabBarView:(id)tabBar didSelectedButtonFrom:(NSInteger)from toIndex:(NSInteger)index
{
    if ([self shouldSelectViewControllerFromIndex:index]) {
        
        [self didSelectedButtonFrom:from toIndex:index];
        self.selectedIndex = index;
        return YES;
    }
    return NO;
}

- (UIView *)tabbarViewCustomViewInTabbarView:(AGBaseTabBarView *)tabbarView
{
    return nil;
}

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -

@end
