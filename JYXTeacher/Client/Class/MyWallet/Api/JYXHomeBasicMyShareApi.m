//
//  JYXHomeBasicMyShareApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/26.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeBasicMyShareApi.h"

@implementation JYXHomeBasicMyShareApi
{
    NSString *_userid;
    NSString *_token;
}

- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token
{
    self = [super init];
    if (self) {
        _userid = userid;
        _token = token;
        self.validator = self;
    }
    return self;
}

#pragma mark - RXAPIManagerParams
- (RXRequestMethod)methodName
{
    return RXRequestMethodPost;
}

- (NSString *)detailUrl
{
    return @"home/basic/my_share";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_userid forKey:@"userid"];
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:@2 forKey:@"type"];
    return dictM;
}

#pragma mark - RXApiManagerDataReformer -
- (id)requestManager:(RXBaseRequest *)manager reformData:(NSDictionary *)data
{
    return data[@"result"];
}

#pragma mark - RXAPIManagerValidator
- (BOOL)requestManager:(RXBaseRequest *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}

- (BOOL)requestManager:(RXBaseRequest *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        
        NSNumber *business = data[@"code"];
        if (business.intValue == 1000) {
            
            if ([data[@"result"] isKindOfClass:[NSDictionary class]]) {
                
                return YES;
            }
        } else {
            [MBProgressHUD showInfoMessage:data[@"msg"]];
            return NO;
        }
    }
    return NO;
}

@end
