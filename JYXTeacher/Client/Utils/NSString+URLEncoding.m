//
//  NSString+URLEncoding.m
//  juliye-iphone
//
//  Created by 洪聪 on 15/5/8.
//  Copyright (c) 2015年 zlycare. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)stringByURLEncoding {
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                        (CFStringRef)self,
                                                                        NULL,
                                                                        (CFStringRef)@"+",
                                                                        CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


+ (NSArray*)subStr:(NSString *)string
{
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch;
        substringForMatch = [string substringWithRange:match.range];
        [arr addObject:substringForMatch];
        
    }
    
    return arr;
    
}
//获取查找字符串在母串中的NSRange
+ (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSRange searchRange = NSMakeRange(0, [str length]);
    
    NSRange range;
    
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        
        [results addObject:[NSValue valueWithRange:range]];
        
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
        
    }
    
    return results;
}

//格式化DocChatNum
+ (NSString *)formatDocChatNum:(NSString *)docChatNum {
    if (docChatNum.length > 5) {
        return [self changeDoctorChatNumberFormat:docChatNum];
    }
    
    return docChatNum;
}

//给热线号每隔3位加-
+ (NSString *)changeDoctorChatNumberFormat:(NSString *)num {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"((\\d{3})(?=\\d))" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSMutableString *result = [NSMutableString string];
    NSArray *matches = [regex matchesInString:num options:0 range:NSMakeRange(0, num.length)];
    //多次匹配
    for (NSTextCheckingResult *match in matches) {
        NSRange range = match.range;
        [result appendString:[num substringWithRange:range]];
        [result appendString:@"-"];
    }
    
    //拼接剩余的串
    NSTextCheckingResult *lastMatch = [matches lastObject];
    [result appendString:[num substringFromIndex:(lastMatch.range.location + lastMatch.range.length)]];
    
    return result;
}

//拨号界面显示的号码格式
+ (NSString *)dialingNumberFormat:(NSString *)num {
    if (num.length > 6 && num.length < 11) {   //输入第7位时变化，但不超过10位时
        return [self changeDoctorChatNumberFormat:num];
    } else if (num.length == 11) {  //11位手机号特殊格式
        return [self cellphoneNumberFormat:num];
    } else {
        //do nothing.
    }
    
    return num; //不满足格式化要求的直接返回原始值
}

//11位手机号格式化为3-4-4的样式
+ (NSString *)cellphoneNumberFormat:(NSString *)cellphoneNum {
    NSMutableString *result = [NSMutableString string];
    NSArray *arr_range = @[[NSValue valueWithRange:NSMakeRange(0, 3)], [NSValue valueWithRange:NSMakeRange(3, 4)]];
    for (NSValue *rangeValue in arr_range) {
        NSRange range = [rangeValue rangeValue];
        [result appendString:[cellphoneNum substringWithRange:range]];
        [result appendString:@"-"];
    }
    
    //拼接剩余的串
    NSRange range = [[arr_range lastObject] rangeValue];
    [result appendString:[cellphoneNum substringFromIndex:(range.location + range.length)]];
    
    return result;
}

//正则手机号
- (BOOL)checkPhoneNumInput {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188 (147 178)
     * 联通：130,131,132,152,155,156,185,186 (145 176)
     * 电信：133,1349,153,180,189 (177 181 170)
     */
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[678]|8[0125-9])\\d{8}$";;
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|4[7]|5[017-9]|7[8]|8[123478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|4[5]|5[256]|7[6]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189, 181,170
     22         */
    NSString * CT = @"^1((33|53|8[019]|7[07])[0-9]|349|77)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)){
        return YES;
    }
    else{
        return NO;
    }
}

//正则是否为电话号码
+ (BOOL)isTelNum:(NSString *)telNum {
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextesTel = [NSPredicate predicateWithFormat:@"SELF     MATCHES %@", PHS];
    if ([regextesTel evaluateWithObject:telNum]) {
        return YES;
    } else {
        return NO;
    }
}

@end
