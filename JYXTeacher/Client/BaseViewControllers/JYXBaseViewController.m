//
//  JYXBaseViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXBaseViewController.h"

@interface JYXBaseViewController ()

@end

@implementation JYXBaseViewController

#pragma mark - lifeCycle                    - Method -

- (void)dealloc
{
    NSLog(@"%@ ------> %@", NSStringFromSelector(_cmd), NSStringFromClass([self class]));
    
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        [self setLeftBarButton:@"navi_Return"];
    }
    
    UIImage *backgroundImage = [UIImage imageNamed:@"navBarBg"];
    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    UIImage *shadowImage = [UIImage imageWithColor:[UIColor clearColor]
                                     size:CGSizeMake(self.navigationController.navigationBar.size.width, 0.5)];
    
    
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage
                                                  forBarMetrics:UIBarMetricsDefault];
    
    UIColor *titleColor = [UIColor colorWithHex:0xffffff];
    [self.navigationController.navigationBar setShadowImage:shadowImage];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : titleColor,
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
}

/**
 *  显示导航栏左边Button
 *
 *  @param image png 图片
 */
- (void)setLeftBarButton:(NSString *)image
{
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithTarget:self
                                                         action:@selector(naviBack:)
                                                          image:image
                                                      highImage:image];
    self.navigationItem.leftBarButtonItem = backItem;
}

/**
 *  显示导航栏右边Button
 *
 *  @param image png 图片
 */
- (void)setRightBarButton:(NSString *)image
{
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithTarget:self
                                                          action:@selector(naviRight:)
                                                           image:image
                                                       highImage:image];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - eventResponse                - Method -

/**
 返回按钮的事件:默认pop上一级，子类可重写方法实现
 
 @param btn 返回按钮
 */
- (void)naviBack:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 子类可重写方法实现
 
 @param btn 按钮
 */
- (void)naviRight:(UIButton *)btn
{
    
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    } else {
        
        //        NSLog(@"===%@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
        result = nextResponder;
    } else {
        result = [UIViewController new];
    }
    
    return result;
}

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (void)setResult:(NSDictionary *)param
{
    if (!param) return;
    _parameter = [param mutableCopy];
}

@end
