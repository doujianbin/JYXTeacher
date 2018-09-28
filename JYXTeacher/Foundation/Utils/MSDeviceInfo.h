//
//  MSDeviceInfo.h
//  MyShowFoundation
//
//  Created by Michael Ge on 15/11/9.
//  Copyright © 2015年 Beijin MaiXiu Interaction Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSDeviceInfo : NSObject
/**
 *  获取机器时间
 *
 *  @return 自开机以后经过的纳秒数（10负9次方秒）
 */
+(uint64_t)getMachAbsoluteTime;
/**
 *  获取GUID
 *
 *  @return GUID字符串
 */
+ (NSString *)GUID;

/**
 *  获取UDID
 *
 *  @return UDID字符串
 */
+ (NSString*)UDID;

/**
 *  获取设备类型
 *
 *  @return 设备类型名称
 */
+ (NSString *)getDeviceType;

/**
 *  设备版本
 *
 *  @return e.g. iPhone 5S
 */
+ (NSString*)deviceVersion;
@end
