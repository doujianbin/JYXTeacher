//
//  JYXApplicationConfig.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXApplicationConfig.h"

static NSDictionary *configServerAddressList;

@implementation JYXApplicationConfig

+ (void)initialize
{
    //读取 config.plist 中的配置信息
    NSString* configuration = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"Configuration"];
    NSString* filename = [@"config_" stringByAppendingString:configuration];
    
    NSString *plistPath  = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    configServerAddressList = [dict valueForKey:@"ServerAddress"];
}

/**
 * 获取服务器地址列表，内容为 config 文件中的 ServerAddress 节点内容。
 * @return 获取服务器地址列表
 */
+ (NSDictionary * _Nullable)getServerAddressList
{
    return configServerAddressList;
}

/**
 * 获取服务器地址，ServerAddress -> msvr:// 节点内容。
 * @return 获取media服务器地址
 */
+ (NSString * _Nullable)getServerAddress
{
    return configServerAddressList[@"msvr://"];
}

/**
 * 获取media服务器地址，ServerAddress -> msvr:// 节点内容。
 * @return 获取media服务器地址
 */
+ (NSString * _Nullable)getMediaServerAddress
{
    return configServerAddressList[@"img://"];
}

@end
