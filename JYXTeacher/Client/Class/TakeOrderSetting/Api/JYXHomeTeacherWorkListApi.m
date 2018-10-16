//
//  JYXHomeTeacherWorkListApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeTeacherWorkListApi.h"

@implementation JYXHomeTeacherWorkListApi
{
    NSNumber *_teacherid;
    NSString *_token;
    NSNumber *_type;
    NSString *_starttime;
    NSNumber *_page;
    NSNumber *_limitnum;
}

- (nonnull instancetype)initWithTeacherid:(NSNumber *)teacherid
                                    token:(nonnull NSString *)token
                                     type:(NSNumber *)type
                                 startime:(NSString *)startime
                                     page:(NSNumber *)page
                                 limitnum:(NSNumber *)limitnum
{
    self = [super init];
    if (self) {
        _teacherid = teacherid;
        _token = token;
        _type = type;
        _starttime = startime;
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
    return @"home/teacher/work_list";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_teacherid forKey:@"teacherid"];
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:_type forKey:@"type"];
    [dictM setValue:_starttime forKey:@"startime"];
    [dictM setValue:_page forKey:@"page"];
    [dictM setValue:_limitnum forKey:@"limitnum"];
    return dictM;
}

#pragma mark - RXApiManagerDataReformer -
- (id)requestManager:(RXBaseRequest *)manager reformData:(NSDictionary *)data
{
    if (_type.integerValue==1) {
        return data[@"result"];
    } else if (_type.integerValue==2) {
        return data[@"result"];
    }
    return nil;
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
            return YES;
        } else {
            [WLToast show:data[@"msg"]];
            return NO;
        }
    }
    return NO;
}

@end
