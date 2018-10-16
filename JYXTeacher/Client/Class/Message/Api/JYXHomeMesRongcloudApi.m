//
//  JYXHomeMesRongcloudApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeMesRongcloudApi.h"

@implementation JYXHomeMesRongcloudApi
{
    NSNumber *_userid;
    NSString *_username;
    NSNumber *_type;
}

- (nonnull instancetype)initWithUserId:(nonnull NSNumber *)userid username:(NSString *)username type:(NSNumber *)type
{
    self = [super init];
    if (self) {
        _userid = userid;
        if (username) {
            _username = @"教予学教师";
        }else{
            _username = username;
        }
        _type = type;
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
    return @"home/mes/rongcloud";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_userid forKey:@"userid"];
    [dictM setValue:_username forKey:@"username"];
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
