//
//  MSDBResultSet.h
//  MyShowFoundation
//
//  Created by Michael Ge on 15/12/28.
//

#import <Foundation/Foundation.h>

@interface MSDBResultSet : NSObject
- (instancetype)initWithResultSet:(id)result;

/**
 *  跳转至下一记录
 *
 *  @return 是否有下一条记录
 */
- (BOOL)next;

// 关闭结果集
- (void)close;

// 字段总数
- (int)columnCount;

// 获取字段名
- (NSString *)columnNameForIndex:(int)columnIndex;

// 获取字段名对应的int值
- (int)intForColumn:(NSString *)columnName;
// 获取字段索引对应的int值
- (int)intForColumnIndex:(int)columnIndex;

// 获取字段名对应的long值
- (long)longForColumn:(NSString *)columnName;
// 获取字段索引对应的long值
- (long)longForColumnIndex:(int)columnIndex;

// 获取字段名对应的long long int值
- (long long int)longLongIntForColumn:(NSString *)columnName;
// 获取字段索引对应的long long int值
- (long long int)longLongIntForColumnIndex:(int)columnIndex;

// 获取字段名对应的无符号long long int值
- (unsigned long long int)unsignedLongLongIntForColumn:(NSString *)columnName;
// 获取字段索引对应的无符号long long int值
- (unsigned long long int)unsignedLongLongIntForColumnIndex:(int)columnIndex;

// 获取字段名对应的布尔值
- (BOOL)boolForColumn:(NSString *)columnName;
// 获取字段索引对应的布尔值
- (BOOL)boolForColumnIndex:(int)columnIndex;

// 获取字段名对应的double值
- (double)doubleForColumn:(NSString *)columnName;
// 获取字段索引对应的double值
- (double)doubleForColumnIndex:(int)columnIndex;

// 获取字段名对应的NSString值
- (NSString *)stringForColumn:(NSString *)columnName;
// 获取字段索引对应的NSString值
- (NSString *)stringForColumnIndex:(int)columnIndex;

// 获取字段名对应的NSDate值
- (NSDate *)dateForColumn:(NSString *)columnName;
// 获取字段索引对应的NSDate值
- (NSDate *)dateForColumnIndex:(int)columnIndex;

// 获取字段名对应的NSData值
- (NSData *)dataForColumn:(NSString *)columnName;
// 获取字段索引对应的NSData值
- (NSData *)dataForColumnIndex:(int)columnIndex;
@end
