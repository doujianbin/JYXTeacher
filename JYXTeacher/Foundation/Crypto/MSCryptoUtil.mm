//
//  MSCryptoUtil.m
//  MyShowFoundation
//
//  Created by Michael Ge on 15/12/17.
//

#import "MSCryptoUtil.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+Extension.h"
#import "MSDigest.h"
#import "MSDataConvertionUtil.h"

//摘要字符串变换表，最后一个字符 'X' 用于表示无效字符。
static char DIGEST_TRANSFORM_TABLE[] = {'d', 'E', 'F', 'A', 'b', 'c', '0', '1', '2', '3', 'f', '5', '6', '7', '8', '9', 'X'};

@implementation MSCryptoUtil
+(NSString*)transformDigestWithString:(NSString*)digest
{
    if ([NSString isEmpty:digest]) {
        return @"";
    }
    
    NSUInteger length = [digest lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    NSUInteger bufferLength = length + 1;
    char* buffer    = new char[bufferLength];
    char* original  = new char[bufferLength];
    memset(buffer, 0, bufferLength);
    
    [digest getCString:original maxLength:bufferLength encoding:NSUTF8StringEncoding];
    
    for (NSUInteger i=0;i<length;i++){
        char c = original[i];
        if (c >= '0' && c <= '9'){
            c = c - '0';
        }
        else if (c >= 'A' && c <= 'F'){
            c = c - 'A' + 10;
        }
        else if (c >= 'a' && c <= 'f'){
            c = c - 'a' + 10;
        }
        else {
            //字符不在十六进制字符串内，则无效用 'X' 表示。
            c = sizeof(DIGEST_TRANSFORM_TABLE) - 1;
        }
        
        buffer[i] = DIGEST_TRANSFORM_TABLE[c];
    }

    NSString* result = [NSString stringWithUTF8String:buffer];
    delete[] buffer;
    delete[] original;
    
    return result;
}

+(NSString* _Nonnull)getMSMD5:(NSString* _Nonnull)string
{
    if ([NSString isEmpty:string] ) {
        return @"";
    }
    
    return [self transformDigestWithString:[MSDigest md5:string]];
}

+(NSString * _Nonnull)encryptPassword:(NSString * _Nonnull)pwd key:(NSString * _Nonnull)key
{
    static char salt[] = {(char)0xF1,(char)0x98,(char)0xEC,(char)0xC6,'0','3','6','0'};
    
    return [self desEncrypt:[self transformDigestWithString:[MSDigest md5:pwd]]
                        key:key
                       salt:salt
                    replace:0];
}

+(NSString * _Nonnull)encryptToken:(NSString * _Nonnull)token key:(NSString * _Nonnull)key
{
    return [self desEncrypt:token
                        key:key
                       salt:"\xAF\xAD\x93\xAE\x69\xD3\xB4\x12"
                    replace:3];
}

/**
 * DES 加密
 *
 * @param text 原文字符串
 * @param key  密匙，如果超过 8 个字符则从尾部开始截取8个字符
 * @param salt 盐值，当密有效长度不足8位时用盐值填充，盐值度必须为8字节。
 * @param replaceLength  盐值强制替换长度，如果该参数不为 0 则将 key 开头替换成指定字节数的盐值
 * 
 * @return 加密后的密文（16进制字符串）
 */
+(NSString * _Nonnull)desEncrypt:(NSString * _Nonnull)text
                             key:(NSString * _Nonnull)key
                            salt:(const char*)salt
                         replace:(uint32_t)replaceLength;

{
    if ([NSString isEmpty:text] || [NSString isEmpty:key] ) {
        return @"";
    }
    
    NSString *ciphertext = nil;
    
    const char* textBuffer = [text UTF8String];
    NSUInteger  textBufferLength = [text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    size_t bufferSize = textBufferLength + kCCBlockSizeDES;
    void * buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    Byte desKey[kCCBlockSizeDES];
    const char *keyBuffer = [key UTF8String];
    
    memcpy(desKey,salt, 8);
    
    if (key.length<=8){
        memcpy(desKey, keyBuffer, key.length);
    }
    else{
        memcpy(desKey, keyBuffer + key.length - 8, 8);
    }
    
    if (replaceLength > 0){
        if (replaceLength > 8){
            replaceLength = 8;
        }

        memcpy(desKey,salt,replaceLength);
    }
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          desKey,kCCKeySizeDES,
                                          desKey, /*向量*/
                                          textBuffer,textBufferLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSLog(@"DES加密成功");
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [MSDataConvertionUtil nsdataToHexString:data];
        
    }
    else{
        NSLog(@"DES加密失败");
    }
    
    free(buffer);
    return ciphertext;
}
@end
