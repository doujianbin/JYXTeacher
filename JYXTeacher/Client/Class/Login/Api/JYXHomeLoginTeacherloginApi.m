//
//  JYXHomeLoginTeacherloginApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeLoginTeacherloginApi.h"

@implementation JYXHomeLoginTeacherloginApi
{
    NSString *_phone;
    NSString *_sms;
}

- (nonnull instancetype)initWithPhone:(nonnull NSString *)phone withSMS:(nonnull NSString *)sms
{
    self = [super init];
    if (self) {
        _phone = phone;
        _sms = sms;
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
    return @"home/login/teacherlogin";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_phone forKey:@"phone"];
    [dictM setValue:_sms forKey:@"sms"];
    [dictM setObject:[[NSUserDefaults standardUserDefaults] valueForKey:Registionid] forKey:@"rid"];
    return dictM;
}

#pragma mark - RXApiManagerDataReformer -
- (id)requestManager:(RXBaseRequest *)manager reformData:(NSDictionary *)data
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    [user clear];
    [user configUserData:data[@"result"]];
    return @([[JYXUserManager shareInstance] save]);
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
