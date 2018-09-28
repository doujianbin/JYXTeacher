//
//  MSFile.h
//  MyShowFoundation
//
//  Created by Michael Ge on 15/11/9.
//

#import <Foundation/Foundation.h>
//#import "MSJSONObject.h"
//#import "MSJSONArray.h"

@interface MSFile : NSObject

/**
 *  确保子路径在 Library 目录中存在，如果不存则创建它。
 *
 *  @param subPath 子路径
 *  @param skip 当创建子路径时，指示其是否跳过 iCloud 自动备份
 *
 *  @return 如果路径存在或创建成功返回完成路径，否则返回 nil。
 */
+ (NSString * _Nullable)ensureDirectoryInLibrary:(NSString * _Nonnull)subPath skipBackup:(BOOL)skip;

/**
 *  确保子路径在 Document 目录中存在，如果不存则创建它。
 *
 *  @param subPath 子路径
 *  @param skip 当创建子路径时，指示其是否跳过 iCloud 自动备份
 *
 *  @return 如果路径存在或创建成功返回完成路径，否则返回 nil。
 */
+ (NSString * _Nullable)ensureDirectoryInDocument:(NSString * _Nonnull)subPath skipBackup:(BOOL)skip;

/**
 *  确保子路径在 Cache 目录中存在，如果不存则创建它。
 *
 *  @param subPath 子路径
 *
 *  @return 如果路径存在或创建成功返回完成路径，否则返回 nil。
 */
+ (NSString * _Nullable)ensureDirectoryInCache:(NSString * _Nonnull)subPath;

/**
 *  确保某一个目录存在，如果不存在则尝试创建这个目录。
 *
 *  @param path 目录的全路径
 *
 *  @return 如果目录存在 1，如果创建成功返回 2，如果创建失败则返回 0。
 */
+(int)ensureDirectory:(NSString* _Nonnull)path;

/**
 *  判断一个文件或路径是否存在。
 *
 *  @param fullPath 等检测的路径
 *
 *  @return 是否存在
 */
+ (BOOL)isExist:(NSString * _Nonnull)fullPath;

/**
 *  按文本模式读取文件内容
 *
 *  @param fullPath 文件全路径
 *
 *  @return 返回文件内容，如果文件不存在则返回容，如果文件内容为空则返回空串。
 */
+ (NSString* _Nullable) readFileWithString:(NSString * _Nonnull)fullPath;

/**
 *  按 JSONObject 模式读取文件内容
 *
 *  @param fullPath 文件全路径
 *
 *  @return 返回文件内容，如果文件不存在、内容为空、格式正确则返回 null。
 */
//+ (MSJSONObject* _Nullable) readFileWithJSONObject:(NSString * _Nonnull)fullPath;

/**
 *  按 JSONArray 模式读取文件内容
 *
 *  @param fullPath 文件全路径
 *
 *  @return 返回文件内容，如果文件不存在、内容为空、格式正确则返回 null。
 */
//+ (MSJSONArray* _Nullable) readFileWithJSONArray:(NSString * _Nonnull)fullPath;

/**
 *  解压缩 Zip 文件
 *
 *  @param zipFilePath Zip 文件路径
 *  @param directory   展开目录，如果目录中有文件将会被覆盖。
 *
 *  @return 如果解压缩成功则返回 true。
 */
//+ (BOOL)decompressZip:(NSString *_Nonnull)zipFilePath target:(NSString *_Nonnull)directory;

/**
 *  写入文件
 *  如果文件不存在则创建并写入数据，如果已存在则覆盖；
 *  @param path 文件路径
 *  @param text 写入内容(UT8 编码保存)
 *
 *  @return 写入文件结果，写入文件失败或文件目录不存在则返回 NO。
 */
+ (BOOL)writeFile:(NSString * _Nonnull)path text:(NSString * _Nonnull)text;

/**
 *  写入文件
 *  如果文件不存在则创建并写入数据，如果已存在则覆盖；
 *
 *  @param path 文件路径
 *  @param data 数据(NSData)
 *
 *  @return 写入文件结果，写入文件失败或文件目录不存在则返回 NO
 */
+ (BOOL)writeFile:(NSString *_Nonnull)path data:(NSData * _Nonnull)data;

/**
 *  删除文件
 *
 *  @param path 文件路径
 *
 *  @return 删除结果
 */
+ (BOOL)removeFile:(NSString * _Nonnull)path;

/**
 *  创建文件
 *  如果文件不存在则创建，如果已存在则直接返回 YES；
 *  @param path 文件名称(含路径)
 *
 *  @return 创建结果，创建文件失败时返回 NO。
 */
+ (BOOL)createFile:(NSString *_Nonnull)path;

/**
 *  复制文件
 *
 *  @param sourcePath   源文件路径
 *  @param desPath      目标文件路径
 *
 *  @return 复制结果
 */
+ (BOOL)copyFile:(NSString *_Nonnull)sourcePath toDesPath:(NSString *_Nonnull)desPath isOverWrite:(BOOL)flag;
@end
