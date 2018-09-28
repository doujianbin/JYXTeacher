//
//  JYXHomeTeacherSubjectEditApi.m
//  JYXTeacher
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeTeacherSubjectEditApi.h"

@implementation JYXHomeTeacherSubjectEditApi
{
    NSString *_userid;
    NSString *_token;
    NSString *_subjectid;
    NSString *_subjectname;
    NSString *_pic;
    NSString *_keyword;
}

- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token subjectid:(NSString *)subjectid subjectname:(NSString *)subjectname pic:(NSString *)pic keyword:(NSString *)keyword
{
    self = [super init];
    if (self) {
        _userid = userid;
        _token = token;
        _subjectid = subjectid;
        _subjectname = subjectname;
        _pic = pic;
        _keyword = keyword;
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
    return @"home/teacher/subject_edit";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_userid forKey:@"userid"];
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:_subjectid forKey:@"id"];
    [dictM setValue:_subjectname forKey:@"name"];
    [dictM setValue:_pic forKey:@"pic"];
    [dictM setValue:_keyword forKey:@"keyword"];
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
            [WLToast show:data[@"msg"]];
            return NO;
        }
    }
    return NO;
}

@end
