//
//  JYXInitializeApplication.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXInitializeApplication.h"
#import "AGTabBarController.h"
#import "RXRequestConfig.h"
#import "JYXApplicationConfig.h"

@implementation JYXInitializeApplication

+ (UIViewController *)initialize:(UIApplication *)application
                         options:(NSDictionary *)launchOptions
{
    /// 设置服务器地址
    [RXRequestConfig setServerAddress:[JYXApplicationConfig getServerAddressList]];
    /// 设置键盘监听管理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; // 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    manager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    /// 返回主视图控制器
    __block AGTabBarController *vc;
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        vc = [[AGTabBarController alloc] init];
        
    });
    
    return vc;
}

@end
