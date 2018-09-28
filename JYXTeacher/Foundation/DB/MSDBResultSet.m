//
//  MSDBResultSet.m
//  MyShowFoundation
//
//  Created by Michael Ge on 15/12/28.
//

#import "MSDBResultSet.h"
#import "FMResultSet.h"

@implementation MSDBResultSet
{
    FMResultSet *_result;
}

- (instancetype)initWithResultSet:(id)result
{
    if (self = [super init])
    {
        _result = result;
    }
    
    return self;
}

#pragma mark -
#pragma mark 结果集操作
/**
 *  跳转至下一记录
 *
 *  @return 是否有下一条记录
 */
- (BOOL)next
{
    return [_result next];
}

// 关闭结果集
- (void)close
{
    [_result close];
}

#pragma mark -
#pragma mark 字段操作
// 字段总数
- (int)columnCount
{
    return [_result columnCount];
}

// 获取字段名
- (NSString *)columnNameForIndex:(int)columnIndex
{
    return [_result columnNameForIndex:columnIndex];
}

#pragma mark -
#pragma mark 获取数据
// 获取字段名对应的int值
- (int)intForColumn:(NSString *)columnName
{
    return [_result intForColumn:columnName];
}

// 获取字段索引对应的int值
- (int)intForColumnIndex:(int)columnIndex
{
    return [_result intForColumnIndex:columnIndex];
}

// 获取字段名对应的long值
- (long)longForColumn:(NSString *)columnName
{
    return [_result longForColumn:columnName];
}

// 获取字段索引对应的long值
- (long)longForColumnIndex:(int)columnIndex
{
    return [_result longForColumnIndex:columnIndex];
}

// 获取字段名对应的long long int值
- (long long int)longLongIntForColumn:(NSString *)columnName
{
    return [_result longLongIntForColumn:columnName];
}

// 获取字段索引对应的long long int值
- (long long int)longLongIntForColumnIndex:(int)columnIndex
{
    return [_result longLongIntForColumnIndex:columnIndex];
}

// 获取字段名对应的无符号long long int值
- (unsigned long long int)unsignedLongLongIntForColumn:(NSString *)columnName
{
    return [_result unsignedLongLongIntForColumn:columnName];
}

// 获取字段索引对应的无符号long long int值
- (unsigned long long int)unsignedLongLongIntForColumnIndex:(int)columnIndex
{
    return [_result unsignedLongLongIntForColumnIndex:columnIndex];
}

// 获取字段名对应的布尔值
- (BOOL)boolForColumn:(NSString *)columnName
{
    return [_result boolForColumn:columnName];
}

// 获取字段索引对应的布尔值
- (BOOL)boolForColumnIndex:(int)columnIndex
{
    return [_result boolForColumnIndex:columnIndex];
}

// 获取字段名对应的double值
- (double)doubleForColumn:(NSString *)columnName
{
    return [_result doubleForColumn:columnName];
}

// 获取字段索引对应的double值
- (double)doubleForColumnIndex:(int)columnIndex
{
    return [_result doubleForColumnIndex:columnIndex];
}

// 获取字段名对应的NSString值
- (NSString *)stringForColumn:(NSString *)columnName
{
    return [_result stringForColumn:columnName];
}

// 获取字段索引对应的NSString值
- (NSString *)stringForColumnIndex:(int)columnIndex
{
    return [_result stringForColumnIndex:columnIndex];
}

// 获取字段名对应的NSDate值
- (NSDate *)dateForColumn:(NSString *)columnName
{
    return [_result dateForColumn:columnName];
}

// 获取字段索引对应的NSDate值
- (NSDate *)dateForColumnIndex:(int)columnIndex
{
    return [_result dateForColumnIndex:columnIndex];
}

// 获取字段名对应的NSData值
- (NSData *)dataForColumn:(NSString *)columnName
{
    return [_result dataForColumn:columnName];
}

// 获取字段索引对应的NSData值
- (NSData*)dataForColumnIndex:(int)columnIndex
{
    return [_result dataForColumnIndex:columnIndex];
}
@end
