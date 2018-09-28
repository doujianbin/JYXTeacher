//
//  JYXHomeStudentTeacherTimeApi.m
//  JYXTeacher
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeStudentTeacherTimeApi.h"

@implementation JYXHomeStudentTeacherTimeApi
{
    NSString *_userid;
    NSString *_token;
    NSString *_teacherid;
    NSString *_time;
}

- (nonnull instancetype)initWithUserid:(NSString *)userid token:(NSString *)token teacherid:(NSString *)teacherid time:(NSString *)time
{
    self = [super init];
    if (self) {
        _userid = userid;
        _token = token;
        _teacherid = teacherid;
        _time = time;
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
    return @"home/student/teacher_time";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_userid forKey:@"userid"];
    [dictM setValue:_teacherid forKey:@"id"];
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:_time forKey:@"time"];
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
            
            if ([[data[@"result"] firstObject] isKindOfClass:[NSDictionary class]]) {
                
                return YES;
            }
        } else {
            [WLToast show:data[@"msg"]];
            return NO;
        }
    }
    return NO;
}

@end
