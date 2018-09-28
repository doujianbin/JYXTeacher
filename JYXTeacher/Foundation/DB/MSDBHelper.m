//
//  MSDBHelper.m
//  MyShowFoundation
//
//  Created by Michael Ge on 15/12/28.
//

#import "MSDBHelper.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "MSDigest.h"
#import "MSFile.h"
#import "MSPath.h"

@interface FMDatabase ()

- (FMResultSet *)executeQuery:(NSString *)sql
         withArgumentsInArray:(NSArray*)arrayArgs
                 orDictionary:(NSDictionary *)dictionaryArgs
                     orVAList:(va_list)args;

- (BOOL)executeUpdate:(NSString*)sql
                error:(NSError**)outErr
 withArgumentsInArray:(NSArray*)arrayArgs
         orDictionary:(NSDictionary *)dictionaryArgs
             orVAList:(va_list)args;

@end

static NSMutableDictionary *MSOpenedDatabaseConnectPool;

@implementation MSDBHelper
{
    FMDatabase *_db;        // 数据库
    NSString   *_dbfilemd5; // 当前数据库文件的 md5，是 MSOpenedDatabaseConnectPool 中的 key。
}

-(void)dealloc
{
    if (_db){
        [self close];
    }
}


#pragma mark -
#pragma mark get/set方法重写

/**
 *  数据库名字（不含路径及扩展名），如果不指定则打开缺省数据库，如果数据库已经打开则修改无效
 *  @param fileName 数据库名字
 */
- (void)setFileName:(NSString *)fileName
{
    @synchronized(_db) {
        if (_db){
            return;
        }
        
        _fileName   = [fileName copy];
        _dbfilemd5  = [MSDigest md5:_fileName];
    }
}

/**
 *  重写 key 的 set 方法；如果数据库已成功链接，设置密钥
 */
- (void)setKey:(NSString *)key
{
    _key = [key copy];
    
    @synchronized(_db) {
        if (self.key) {
            [_db rekey:self.key];
        }
    }
}

#pragma mark -
#pragma mark 数据链接打开关闭
/**
 *  打开数据库链接, 如果密钥已赋值，设置密钥
 *
 *  @return 数据库链接是否正常打开
 */
- (BOOL)open
{
    // 如果没有指定数据库名称则打开缺省数据库
    if (!self.fileName || self.fileName.length == 0) {
        self.fileName = @"yiXiuGe";
    }
    
    // 缺省密码
    if (!self.key) {
        self.key = @".JYXVIP#$";
    }
    
    BOOL connect = NO;
    @synchronized(MSOpenedDatabaseConnectPool) {
        @synchronized(_db) {
            if(_db){
                return YES;
            }
            
            if (!MSOpenedDatabaseConnectPool) {
                MSOpenedDatabaseConnectPool = [NSMutableDictionary dictionary];
            }
            
            //如果数据库已经打开则从连接池中取出这个连接，如果没有打开则打开数据库并放入连接池中。
            if ([MSOpenedDatabaseConnectPool valueForKey:_dbfilemd5]) {
                id o = [MSOpenedDatabaseConnectPool valueForKey:_dbfilemd5];
                FMDatabase* fmdb = [o valueForKey:@"db"];
                uint32_t count = [[o valueForKey:@"count"] unsignedIntValue] + 1;
                [MSOpenedDatabaseConnectPool setValue:@{@"db":fmdb,@"count":@(count)} forKey:_dbfilemd5];
                
                _db = fmdb;
            } else {
                
                NSString *fullPath = [MSPath fullPathFromAssetsInLibrary:[NSString stringWithFormat:@"Database/User/%@.sqlite", _fileName]];
                [MSFile ensureDirectory:[MSPath fullPathFromAssetsInLibrary:@"Database/User"]];
                
                FMDatabase* fmdb = [FMDatabase databaseWithPath:fullPath];
                connect    = [fmdb open];
                if (connect){
                    [MSOpenedDatabaseConnectPool setValue:@{@"db":fmdb,@"count":@(1)} forKey:_dbfilemd5];
                }
                
                _db = fmdb;
            }
            
            if (connect && self.key) {
                [_db setKey:self.key];
            }
        }
    }
    
    return connect;
}

/**
 *  关闭数据库链接
 *
 *  @return 数据链接关闭是否已经关闭
 */
- (BOOL)close
{
    BOOL isClose = NO;
    @synchronized(MSOpenedDatabaseConnectPool) {
        @synchronized(_db) {
            if(!_db){
                return YES;
            }
            
            id o = [MSOpenedDatabaseConnectPool valueForKey:_dbfilemd5];
            uint32_t count = [[o valueForKey:@"count"] unsignedIntValue] - 1;
            FMDatabase* fmdb = [o valueForKey:@"db"];
            
            if (count == 0) {
                isClose = [fmdb close];
            }
            else{
                [MSOpenedDatabaseConnectPool setValue:@{@"db":fmdb,@"count":@(count)} forKey:_dbfilemd5];
            }
            
            if (isClose) {
                [MSOpenedDatabaseConnectPool removeObjectForKey:_dbfilemd5];
            }
            
            _db = nil;
        }
    }
    
    return isClose;
}

// 所影响的记录数
- (int)changes
{
    return [_db changes];
}

- (BOOL)tableExists:(NSString*)tableName
{
    return [_db tableExists:tableName];
}

#pragma mark -
#pragma mark 数据库查询
/**
 *  数据库查询
 *
 *  @param sql 查询sql, 可以用类似format方法传变量
 *
 *  @return 返回查询结果集
 */
- (MSDBResultSet *)executeQuery:(NSString*)sql, ...
{
    @synchronized (_db)
    {
        if (!_db){
            return nil;
        }
        
        va_list args;
        va_start(args, sql);
        
        id result = [_db executeQuery:sql
                 withArgumentsInArray:nil
                         orDictionary:nil
                             orVAList:args];
        
        va_end(args);
        return [[MSDBResultSet alloc] initWithResultSet:result];
    }
}

/**
 *  数据库查询
 *
 *  @param sql  更新数据sql, 操作有insert, update, delete
 *  @param args 更新数据sql
 *
 *  @return 返回查询结果集
 */
- (MSDBResultSet *)executeQuery:(NSString *)sql args:(NSArray *)args
{
    @synchronized (_db)
    {
        if (!_db){
            return nil;
        }
        
        return [[MSDBResultSet alloc] initWithResultSet:[_db executeQuery:sql
                                                     withArgumentsInArray:args]];
    }
}

#pragma mark -
#pragma mark 数据更新
- (BOOL)executeUpdate:(NSString*)sql, ...
{
    @synchronized (_db)
    {
        if (!_db){
            return NO;
        }
        
        va_list args;
        va_start(args, sql);
        
        BOOL result = [_db executeUpdate:sql
                                   error:nil
                    withArgumentsInArray:nil
                            orDictionary:nil
                                orVAList:args];
        
        va_end(args);
        return result;
    }
}

/**
 *  数据库更新
 *
 *  @param sql  更新数据sql, 操作有insert, update, delete
 *  @param args 更新数据sql
 *
 *  @return 返回是否成功执行
 */
- (BOOL)executeUpdate:(NSString*)sql args:(NSArray *)args
{
    @synchronized (_db)
    {
        if (!_db){
            return NO;
        }
        
        return [_db executeUpdate:sql withArgumentsInArray:args];
    }
}

@end
