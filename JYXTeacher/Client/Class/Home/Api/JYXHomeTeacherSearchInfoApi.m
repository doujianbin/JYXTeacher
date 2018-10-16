//
//  JYXHomeTeacherSearchInfoApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeTeacherSearchInfoApi.h"

@implementation JYXHomeTeacherSearchInfoApi
{
    NSString *_userid;
    NSString *_token;
    NSNumber *_courseId;
    NSNumber *_type;
}

- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token courseId:(NSNumber *)courseId type:(NSNumber *)type
{
    self = [super init];
    if (self) {
        _userid = userid;
        _token = token;
        _courseId = courseId;
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
    if (_type.integerValue == 2) {
        return @"home/teacher/search_info";
    }
    return @"home/teacher/course_info";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    if (_type.integerValue == 2) {
        [dictM setValue:_userid forKey:@"userid"];
    } else {
        [dictM setValue:_userid forKey:@"teacherid"];
    }
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:_courseId forKey:@"id"];
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
