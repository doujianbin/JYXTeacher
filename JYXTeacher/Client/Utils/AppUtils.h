//
//  AppUtils.h
//  zlydoc+iphone
//
//  Created by Ryan on 14+5+23.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AppUtils : NSObject

/********************** System Utils ***********************/

//生成uuid
+ (NSString *)uuid;

//检查网络是否连接
+ (BOOL)isConnectionAvailable;

//获取设备类型
+ (NSString *)deviceName;

+ (UIViewController *)activityViewController;

@end
