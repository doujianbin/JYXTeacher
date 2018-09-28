//
//  NSDictionary+MYAddition.h
//  MiYaBaoBei
//
//  Created by ZuoPengHui on
//  Copyright (c) 2017年 ZuoPengHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MYAddition)

@end

@interface NSDictionary (MYParsing)

- (NSString *)    parseStringForKey    :(NSString *)key;
- (NSArray  *)    parseArrayForKey     :(NSString *)key;
- (NSNumber *)    parseNumberForKey    :(NSString *)key;
- (BOOL)          parseBooleanForKey   :(NSString *)key;
- (NSDictionary *)parseDictionaryForKey:(NSString *)key;

@end

@interface NSDictionary (YMJSON)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data;
- (NSString *)toJSONString;

@end
