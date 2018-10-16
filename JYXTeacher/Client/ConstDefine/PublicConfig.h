//
//  PublicConfig.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#ifndef LifeC_PublicConfig_h
#define LifeC_PublicConfig_h

///------
/// NSLog
///------

#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

#define JYXLogError(error) NSLog(@"Error: %@", error)

///------
/// Block
///------

///------
/// Color
///------
#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define JYX_1PX_WIDTH (1 / [UIScreen mainScreen].scale)

///---------
/// App Info
///---------

#define kAppDelegate                [UIApplication sharedApplication].delegate
#define kAppScheme @"jyxteacher"
#define RCIMAppKey @"x18ywvqfxbupc"

#define JYXApplicationVersionKey @"JYXApplicationVersionKey"
#define JYX_APP_ID               @""
#define JYX_APP_STORE_URL        [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",JYX_APP_ID]

#define JYX_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define JYX_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define JYX_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

///-----
/// FMDB
///-----


///-------------
/// Notification
///-------------


///--------
/// Bugtags
///--------


///--------
/// Device
///--------

#define IS_IPAD                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA               ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH       (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH       (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS     (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5             (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6             (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P            (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X            (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
/** 底部栏高度(针对iPhone X做的判断) */
#define kAddBottomHeight                   (IS_IPHONE_X?34:0)

/** 设置frame */
#define FRAME(x, y, w, h)        CGRectMake(x, y, w, h)
/** 设置size */
#define SIZE(w, h)               CGSizeMake(w, h)
/** 设置size */
#define EdgeInsets(top, left, bottom, right)     UIEdgeInsetsMake(top, left, bottom, right)
/** 等比放大 */
#define Iphone6ScaleWidth(default)  (default) * SCREEN_WIDTH / 375.0
#define Iphone6ScaleHeight(default)  (default) * SCREEN_HEIGHT / 667.0

///--------
/// Font
///--------
#define FONT_SIZE(s)           [UIFont systemFontOfSize:s]
//#define FONT_SIZE(s)           [UIFont fontWithName:@"PingFangSC-Medium" size:s]
///--------
/// Version
///--------

#define IOS7                    [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define IOS8                    [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define IOS11 @available(iOS 11.0, *)

/** 循环引用 */
#define WeakSelf(weakSelf)          __weak __typeof(&*self) weakSelf = self;
#define StrongSelf(strongSelf)      __strong __typeof (&*self) strongSelf = weakSelf;

///--------
/// 设置view圆角和边框
///--------
#define JYXViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

///--------
/// 沙盒目录文件
///--------
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

///--------
/// GCD 的宏定义
///--------
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

#endif
