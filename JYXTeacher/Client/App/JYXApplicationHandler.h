//
//  JYXApplicationHandler.h
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JYXApplicationHandler : NSObject
/** 应用的缺省窗口 */
@property (nonatomic, strong, readonly) UIWindow *window;

+ (JYXApplicationHandler *)shareInstance;
/**
 *  初始化应用
 */
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
