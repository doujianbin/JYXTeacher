//
//  JYXHomeTeacherSubjectAddApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeTeacherSubjectAddApi.h"

@implementation JYXHomeTeacherSubjectAddApi
{
    NSString *_userid;
    NSString *_token;
    NSString *_subjectid;
    NSString *_subjectname;
    NSString *_pic;
}

- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token subjectid:(NSString *)subjectid subjectname:(NSString *)subjectname pic:(NSString *)pic
{
    self = [super init];
    if (self) {
        _userid = userid;
        _token = token;
        _subjectid = subjectid;
        _subjectname = subjectname;
        _pic = pic;
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
    return @"home/teacher/subject_add";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_userid forKey:@"userid"];
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:_subjectid forKey:@"subjectid"];
    [dictM setValue:_subjectname forKey:@"subjectname"];
    [dictM setValue:_pic forKey:@"pic"];
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
            
            if ([data[@"result"] isKindOfClass:[NSArray class]]) {
                
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
