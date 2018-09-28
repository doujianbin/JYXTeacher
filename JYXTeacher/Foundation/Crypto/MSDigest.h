//
//  MSDigest.h
//  MyShowFoundation
//
//  Created by Michael Ge on 15/12/8.
//

#import <Foundation/Foundation.h>

@interface MSDigest : NSObject
/**
 *  计算字符串的 MD5 值
 *
 *  @param string 原字符串
 *
 *  @return MD5 字符串 (十六进制字符串）
 */
+ (NSString *)md5:(NSString *)string;

/**
 *  计算字符串的 MD5 值
 *
 *  @param string 原字符串
 *
 *  @return MD5 数据
 */
+ (NSData *)md5Data:(NSString *)string;

/**
 *  获取文件MD5
 *
 *  @param filePath 文件路径
 *
 *  @return 成功返回MD5值，失败返回 nil。
 */
+ (NSString *)getFileMd5:(NSString *)filePath;

/**
 *  获取数据的 MD5
 *
 *  @param data 数据
 *
 *  @return 成功返回MD5值，失败返回 nil。
 */
+ (NSString *)getDataMd5:(NSData *)data;
@end
