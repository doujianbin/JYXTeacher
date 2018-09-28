//
//  MSDBHelper.h
//  MyShowFoundation
//
//  Created by Michael Ge on 15/12/28.
//

#import <Foundation/Foundation.h>
#import "MSDBResultSet.h"

@interface MSDBHelper : NSObject

/**数据库名字（不含路径及扩展名），如果不指定则打开缺省数据库，如果数据库已经打开则修改无效*/
@property(copy, nonatomic, nullable) NSString *fileName;
/**数据库密钥*/
@property(copy, nonatomic, nullable) NSString *key;

/**
 *  打开数据库链接，如果已经打开了数据库则直接返回 YES。
 *
 *  @return 数据库链接打开是否成功
 */
- (BOOL)open;

/**
 *  关闭数据库链接
 *  如果有多个 MSDBHelper 打开了同一个数据库则该方法不会关闭数据库，直到所有打开的对象全部关闭才会返回 YES。
 *  如果当前没有打开数据库则直接返回 YES。
 *  @return 数据链接关闭是否已经关闭
 */
- (BOOL)close;

/**
 *  所影响的记录数
 *
 *  @return 所影响的记录数
 */
- (int)changes;
/**
 *  表是否存在
 *
 *  @param tableName 表名称
 *
 *  @return 存在返回 YES，否则返回 NO。
 */
- (BOOL)tableExists:(NSString* _Nonnull)tableName;

/**
 *  数据库查询
 *
 *  @param sql 查询sql, 可以用类似format方法传变量
 *             eg: @"select * from cache where cachekey=?", @"e10adc3949ba59abbe56e057f20f883e"
 *
 *  @return 返回查询结果集，如果查询失败或没有打开数据库则返回 nil。
 */
- (MSDBResultSet * _Nullable)executeQuery:(NSString* _Nonnull)sql, ...;

/**
 *  数据库查询
 *
 *  @param sql  更新数据sql, 操作有insert, update, delete
 *  @param args 更新数据sql
 *
 *  @return 返回查询结果集，如果查询失败或没有打开数据库则返回 nil。
 */
- (MSDBResultSet * _Nullable)executeQuery:(NSString *_Nonnull)sql args:(NSArray * _Nonnull)args;

/**
 *  数据库更新
 *
 *  @param sql 更新数据sql, 操作有insert, update, delete
 *             eg: @"INSERT INTO cache VALUES (?, ?)", @"e10adc3949ba59abbe56e057f20f883e", @"['12','4545']"
 *
 *  @return 返回是否成功执行
 */
- (BOOL)executeUpdate:(NSString* _Nonnull)sql, ...;

/**
 *  数据库更新
 *
 *  @param sql  更新数据sql, 操作有insert, update, delete
 *  @param args 更新数据sql
 *
 *  @return 返回是否成功执行
 */
- (BOOL)executeUpdate:(NSString* _Nonnull)sql args:(NSArray * _Nonnull)args;
@end
