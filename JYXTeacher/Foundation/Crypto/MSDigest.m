//
//  MSDigest.m
//  MyShowFoundation
//
//  Created by Michael Ge on 15/12/8.
//

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CoreFoundation/CoreFoundation.h>
#import <Security/Security.h>
#import "MSDigest.h"
#import "NSString+Extension.h"

@implementation MSDigest
#pragma mark -
#pragma mark MD5加密

+ (NSString *)md5:(NSString *)string
{
    if ([NSString isEmpty:string]) {
       return @"";
    }
    
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    // This is the md5 call
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSData *)md5Data:(NSString *)string
{
    if ([NSString isEmpty:string]) {
        return [[NSData alloc]init];
    }
    
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    // This is the md5 call
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSData dataWithBytes:result length:sizeof(result)];
}

/**
 *  获取文件MD5
 *
 *  @param filePath 文件路径
 *
 *  @return MD5值
 */
+ (NSString *)getFileMd5:(NSString *)filePath
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if (!handle) {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    
    @try{
        while (!done) {
            NSData *fileData = [handle readDataOfLength:256];
            CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
            if ([fileData length] == 0) {
                done = YES;
            }
        }
        
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5_Final(digest, &md5);
        return  [NSString stringWithFormat:
                 @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                 digest[0], digest[1],
                 digest[2], digest[3],
                 digest[4], digest[5],
                 digest[6], digest[7],
                 digest[8], digest[9],
                 digest[10], digest[11],
                 digest[12], digest[13],
                 digest[14], digest[15]];
    }
    @catch(NSException *e){
        return nil;
    }
}

/**
 *  获取数据的 MD5
 *
 *  @param  data 数据
 *
 *  @return MD5值
 */
+ (NSString *)getDataMd5:(NSData *)data
{
    if (!data) {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    CC_MD5_Update(&md5, [data bytes], (CC_LONG)[data length]);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    return  [NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             digest[0], digest[1],
             digest[2], digest[3],
             digest[4], digest[5],
             digest[6], digest[7],
             digest[8], digest[9],
             digest[10], digest[11],
             digest[12], digest[13],
             digest[14], digest[15]];
}
@end
