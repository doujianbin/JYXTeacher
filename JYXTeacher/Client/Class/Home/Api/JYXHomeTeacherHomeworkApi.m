//
//  JYXHomeTeacherHomeworkApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeTeacherHomeworkApi.h"

@implementation JYXHomeTeacherHomeworkApi
{
    NSString *_courseId;
    NSString *_content;
    NSNumber *_type;
    NSString *_teacherid;
    NSString *_token;
    NSString *_pic;
    NSString *_prepic;
}

- (nonnull instancetype)initWithCourseId:(NSString *)courseId content:(NSString *)content type:(NSNumber *)type teacherid:(NSString *)teacherid token:(NSString *)token pic:(NSString *)pic prepic:(NSString *)prepic
{
    self = [super init];
    if (self) {
        _courseId = courseId;
        _content = content;
        _teacherid = teacherid;
        _token = token;
        _type = type;
        _teacherid = teacherid;
        _pic = pic;
        _prepic = prepic;
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
    return @"home/teacher/homework";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_teacherid forKey:@"teacherid"];
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:_courseId forKey:@"id"];
    [dictM setValue:_pic forKey:@"pic"];
    [dictM setValue:_prepic forKey:@"prepic"];
    [dictM setValue:_content forKey:@"content"];
    [dictM setValue:_type forKey:@"type"];
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
