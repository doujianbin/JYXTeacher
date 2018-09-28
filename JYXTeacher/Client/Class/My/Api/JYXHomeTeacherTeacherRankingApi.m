//
//  JYXHomeTeacherTeacherRankingApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/26.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeTeacherTeacherRankingApi.h"

@implementation JYXHomeTeacherTeacherRankingApi
{
    NSString *_teacherid;
    NSString *_token;
    NSString *_page;
    NSString *_limitnum;
    NSNumber *_cityid;
}

- (nonnull instancetype)initWithTeacherid:(NSString *)teacherid token:(NSString *)token page:(NSString *)page limitnum:(NSString *)limitnum cityid:(NSNumber *)cityid
{
    self = [super init];
    if (self) {
        _teacherid = teacherid;
        _token = token;
        _page = page;
        _limitnum = limitnum;
        _cityid = cityid;
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
    return @"home/teacher/teacher_ranking";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_teacherid forKey:@"teacherid"];
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:_limitnum forKey:@"limitnum"];
    [dictM setValue:_page forKey:@"page"];
    [dictM setValue:_cityid forKey:@"cityid"];
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
            [WLToast show:data[@"msg"]];
            return NO;
        }
    }
    return NO;
}

@end
