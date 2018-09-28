//
//  NSString+Extension.h
//  FHMall
//
//  Created by liruixuan on 16/3/15.
//  Copyright © 2016年 FangLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (CGSize)calculateTextConstrainedInSize:(CGSize)size
                                textFont:(UIFont *)font
                           lineBreakMode:(NSLineBreakMode)mode;

- (BOOL)containsString:(NSString *)string NS_AVAILABLE(10_10, 8_0);

/** 汉字转拼音 */
- (NSString *)transformToPinyin;
/*
 *获取汉字拼音的首字母, 返回的字母是大写形式, 例如: @"俺妹", 返回 @"A".
 *如果字符串开头不是汉字, 而是字母, 则直接返回该字母, 例如: @"b彩票", 返回 @"B".
 *如果字符串开头不是汉字和字母, 则直接返回 @"#", 例如: @"&哈哈", 返回 @"#".
 *字符串开头有特殊字符(空格,换行)不影响判定, 例如@"       a啦啦啦", 返回 @"A".
 */
- (NSString *)pinyinFirstLetter;

/**
 *  字符串是否是数字
 */
- (BOOL)stringisPureIntWithString:(NSString *)string;

/**
 *  测试字符串是否为 nil 或空内容，如果是则返回 YES，否则返回 NO。
 *
 *  @param string 一个字符串
 *
 *  @return 测试字符串是否为 nil 或空内容，如果是则返回 YES，否则返回 NO。
 */
+ (BOOL)isEmpty:(NSString *)string;

/**
 *  国际电话号验证正则
 *
 *  @param mobileNumbel 电话号
 *
 *  @return  YES通过  NO不通过
 */

+ (BOOL)isMobileGuoJi:(NSString *)mobileNumbel;

/**
 *  判断是不是手机号
 */
- (BOOL)valiMobile;


/**
 是否是URL
 */
- (BOOL)isUrl;

/// 字符串比较
+ (NSComparisonResult)compare:(NSString *)str1
                        other:(NSString *)str2
                      options:(NSStringCompareOptions)options;

- (BOOL)isBlankString;
- (BOOL)isNotBlank;

/**
 数据字典转json字符串

 @param dict 需要转换的数据字典
 @return json字符串
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict;
/**
 数组转json字符串
 
 @param array 需要转换的数组
 @return json字符串
 */
+ (NSString *)arrayConvertToJsonData:(NSArray *)array;

/// 判断第一个符是否是字母
- (BOOL)isLetterFirst;

- (BOOL)isChineseFirst;
- (BOOL)isSpecialSymbols;

+ (NSString *)gen_uuid;

/// 超1000显示1k+，超1w显示1w+
- (NSString *)exchangeNumberUnit;

/// 去除两端空格和回车
- (NSString *)trim;

/// 仅去除两端空格
- (NSString *)trimOnlyWhitespace;

/**
 *  空格分割字符串
 *
 *  @return 字符串数据
 */
- (NSArray *)splitUsingWhitespace;

/**
 *  UTC String 时间转换成 本地时间
 *
 *  @return NSDate
 */
- (NSDate *)getLocalDateFromUTCDateStr;

//时间戳转换时间字符串
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

@end


@interface NSString (URLEncode)

- (NSString *)urlEncode;

@end

@interface NSMutableString (AXNetworkingMethods)

- (void)appendURLRequest:(NSURLRequest *)request;

@end
