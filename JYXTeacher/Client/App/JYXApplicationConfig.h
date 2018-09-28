//
//  JYXApplicationConfig.h
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYXApplicationConfig : NSObject
/**
 * 获取服务器地址列表，内容为 config 文件中的 ServerAddress 节点内容。
 * @return 获取服务器地址列表
 */
+ (NSDictionary * _Nullable)getServerAddressList;

/**
 * 获取服务器地址，ServerAddress -> msvr:// 节点内容。
 * @return 获取media服务器地址
 */
+ (NSString * _Nullable)getServerAddress;

/**
 * 获取media服务器地址，ServerAddress -> msvr:// 节点内容。
 * @return 获取media服务器地址
 */
+ (NSString * _Nullable)getMediaServerAddress;

@end
