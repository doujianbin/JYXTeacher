//
//  NSDictionary+MYAddition.h
//  MiYaBaoBei
//
//  Created by ZuoPengHui on
//  Copyright (c) 2017年 ZuoPengHui. All rights reserved.
//

#import "NSDictionary+MYAddition.h"

@implementation NSDictionary (MYAddition)

@end


@implementation NSDictionary (MYParsing)

- (NSString *)parseStringForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }else if ([object isKindOfClass:[NSNumber class]]){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        object = [formatter stringFromNumber:object];
        return object;
    }
    return nil;
}

- (BOOL)parseBooleanForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object boolValue];
    }
    return NO;
}

- (NSNumber *)parseNumberForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    }else if([object isKindOfClass:[NSString class]]){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        object = [formatter numberFromString:object];
        return object;
    }
    return nil;
}

- (NSArray *)parseArrayForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSArray class]]) {
        return object;
    }
    return nil;
}

- (NSDictionary *)parseDictionaryForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return object;
    }
    return nil;
}

@end

@implementation NSDictionary (YMJSON)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data
{
    NSError *error;
    if (data == nil) return [[NSDictionary alloc] init];
    if ([data length] <= 0) return [[NSDictionary alloc] init];
    
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:NSJSONReadingMutableContainers
                                             error:&error];
    
}

- (NSString *)toJSONString
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        return @"";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
}


@end
