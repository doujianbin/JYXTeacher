//
//  JYXHomeTeacherTeacherClassesApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeTeacherTeacherClassesApi.h"

@implementation JYXHomeTeacherTeacherClassesApi
{
    NSString *_teacherid;
    NSString *_token;
    NSString *_year;
    NSString *_mouth;
    NSNumber *_page;
    NSNumber *_limitnum;
}

- (nonnull instancetype)initWithUserid:(nonnull NSString *)teacherid WithToken:(nonnull NSString *)token year:(NSString *)year mouth:(NSString *)mouth page:(NSNumber *)page limitnum:(NSNumber *)limitnum
{
    self = [super init];
    if (self) {
        _teacherid = teacherid;
        _token = token;
        _year = year;
        _mouth = mouth;
        _page = page;
        _limitnum = limitnum;
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
    return @"home/teacher/teacher_classes";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_teacherid forKey:@"teacherid"];
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:_year forKey:@"year"];
    [dictM setValue:_mouth forKey:@"mouth"];
    [dictM setValue:_page forKey:@"page"];
    [dictM setValue:_limitnum forKey:@"limitnum"];
    
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
