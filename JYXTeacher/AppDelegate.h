//
//  AppDelegate.h
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *appKey = @"9ce67bdc962baa16d9abb8c8";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;  // fales 为开发环境  如果上线需改成 true

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIViewController *firstVC;//APP未登录时，记录根视图，在APP登录之后设置该根视图
@property (strong, nonatomic) UIWindow *window;


@end

