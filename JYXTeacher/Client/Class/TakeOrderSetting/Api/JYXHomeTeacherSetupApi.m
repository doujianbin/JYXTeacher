//
//  JYXHomeTeacherSetupApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeTeacherSetupApi.h"

@implementation JYXHomeTeacherSetupApi
{
    NSNumber *_teacherid;
    NSString *_onr;
    NSString *_token;
    NSString *_grade;
    NSString *_subject;
    NSString *_longitude;
    NSString *_lat;
    NSString *_range;
    NSString *_addr;
    NSNumber *_teachertohome;
    NSNumber *_studenttohome;
    NSNumber *_otheraddr;
    NSNumber *_shareaddr;
    NSString *_addrlabel;
    NSString *_times;
}

- (nonnull instancetype)initWithTeacherid:(nonnull NSNumber *)teacherid
                                      onr:(nonnull NSString *)onr
                                    token:(nonnull NSString *)token
                                    grade:(nonnull NSString *)grade
                                  subject:(nonnull NSString *)subject
                                longitude:(NSString *)longitude
                                      lat:(NSString *)lat
                                    range:(NSString *)range
                                     addr:(NSString *)addr
                            teachertohome:(NSNumber *)teachertohome
                            studenttohome:(NSNumber *)studenttohome
                                otheraddr:(NSNumber *)otheraddr
                                shareaddr:(NSNumber *)shareaddr
                                addrlabel:(NSString *)addrlabel
                                    times:(NSString *)times
{
    self = [super init];
    if (self) {
        _teacherid = teacherid;
        _onr = onr;
        _token = token;
        _grade = grade;
        _subject = subject;
        _longitude = longitude;
        _lat = lat;
        _range = range;
        _addr = addr;
        _teachertohome = teachertohome;
        _studenttohome = studenttohome;
        _otheraddr = otheraddr;
        _shareaddr = shareaddr;
        _addrlabel = addrlabel;
        _times = times;
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
    return @"home/teacher/set_up";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    [dictM setValue:_teacherid forKey:@"teacherid"];
    [dictM setValue:_onr forKey:@"onr"];
    [dictM setValue:_token forKey:@"token"];
    [dictM setValue:_grade forKey:@"grade"];
    [dictM setValue:_subject forKey:@"subject"];
    [dictM setValue:_longitude forKey:@"long"];
    [dictM setValue:_lat forKey:@"lat"];
    [dictM setValue:_range forKey:@"range"];
    [dictM setValue:_addr forKey:@"addr"];
    [dictM setValue:_teachertohome forKey:@"teachertohome"];
    [dictM setValue:_studenttohome forKey:@"studenttohome"];
    [dictM setValue:_otheraddr forKey:@"otheraddr"];
    [dictM setValue:_shareaddr forKey:@"shareaddr"];
    [dictM setValue:_addrlabel forKey:@"addrlabel"];
    [dictM setValue:_times forKey:@"times"];
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
