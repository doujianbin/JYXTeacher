//
//  NSString+URLEncoding.h
//  juliye-iphone
//
//  Created by 洪聪 on 15/5/8.
//  Copyright (c) 2015年 zlycare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)

- (NSString *)stringByURLEncoding;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSArray*)subStr:(NSString *)string;

+ (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str;

//格式化DocChatNum
+ (NSString *)formatDocChatNum:(NSString *)docChatNum;
//给热线号每隔3位加-
+ (NSString *)changeDoctorChatNumberFormat:(NSString *)num;
//拨号界面显示的号码格式
+ (NSString *)dialingNumberFormat:(NSString *)num;
//11位手机号格式化为3-4-4的样式
+ (NSString *)cellphoneNumberFormat:(NSString *)cellphoneNum;

//正则是否是手机号
-(BOOL)checkPhoneNumInput;

//正则是否为电话号码
+ (BOOL)isTelNum:(NSString *)telNum;

@end
