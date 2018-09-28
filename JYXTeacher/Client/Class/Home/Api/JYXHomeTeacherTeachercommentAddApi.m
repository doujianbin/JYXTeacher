//
//  JYXHomeTeacherTeachercommentAddApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeTeacherTeachercommentAddApi.h"

@implementation JYXHomeTeacherTeachercommentAddApi
{
    NSNumber *_teacherid;
    NSString *_token;
    NSNumber *_courseId;
    NSString *_teachercomment;
    NSString *_teachercontent;
    NSString *_teacherlabel;
}

- (nonnull instancetype)initWithTeacherid:(NSNumber *)teacherid token:(NSString *)token courseId:(NSNumber *)courseId teachercomment:(NSString *)teachercomment teachercontent:(NSString *)teachercontent teacherlabel:(NSString *)teacherlabel
{
    self = [super init];
    if (self) {
        _teacherid = teacherid;
        _token = token;
        _courseId = courseId;
        _teacherlabel = teacherlabel;
        _teachercomment = teachercomment;
        _teachercontent = teachercontent;
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
    return @"home/teacher/teachercomment_add";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_teacherid forKey:@"teacherid"];
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:_courseId forKey:@"id"];
    [dictM setValue:_teachercontent forKey:@"teachercontent"];
    [dictM setValue:_teachercomment forKey:@"teachercomment"];
    [dictM setValue:_teacherlabel forKey:@"teacherlabel"];
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
