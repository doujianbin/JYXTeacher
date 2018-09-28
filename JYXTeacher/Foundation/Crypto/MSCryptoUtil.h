//
//  MSCryptoUtil.h
//  MyShowFoundation
//
//  Created by Michael Ge on 15/12/17.
//

#import <Foundation/Foundation.h>

@interface MSCryptoUtil : NSObject

/**
 * 变换摘要字符串（十六进制字符串）
 * @param digest  原字符串，不能为空
 *
 * @return 变换后的字符串，如果转换失败返回空串。
 */
+(NSString* _Nonnull)transformDigestWithString:(NSString* _Nonnull)digest;

/**
 * 获取字符串的 MD5字符串（十六进制字符串）
 * @param string  原字符串，不能为空
 *
 * @return MD5字符串（非标准 MD5），如果转换失败返回空串。
 */
+(NSString* _Nonnull)getMSMD5:(NSString* _Nonnull)string;

/**
 * 对登录密码进行加密
 * @param  pwd 原字符串，不能为空
 * @param  key 密钥 (1~8 个字符)
 *
 * @return 加密后的字符串，如果加密失败返回空
 */
+(NSString * _Nonnull)encryptPassword:(NSString * _Nonnull)pwd key:(NSString * _Nonnull)key;

/**
 * 对 Token 进行加密
 * @param  token 原字符串，不能为空
 * @param  key 密钥 (1~8 个字符)
 *
 * @return 加密后的字符串，如果加密失败返回空
 */
+(NSString * _Nonnull)encryptToken:(NSString * _Nonnull)token key:(NSString * _Nonnull)key;
@end
