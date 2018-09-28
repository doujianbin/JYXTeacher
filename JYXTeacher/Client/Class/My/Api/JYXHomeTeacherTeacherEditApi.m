//
//  JYXHomeTeacherTeacherEditApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/26.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeTeacherTeacherEditApi.h"

@implementation JYXHomeTeacherTeacherEditApi
{
    NSString *_userid;
    NSString *_token;
    NSString *_nick;
    NSString *_cardname;
    NSString *_sex;
    NSString *_citypriceone;
    NSString *_citypricetwo;
    NSString *_citypricethree;
    NSString *_citypricefour;
    NSString *_citypricefive;
    NSString *_citypricesix;
    NSString *_citypriceseven;
    NSString *_citypriceeight;
    NSString *_citypricenine;
    NSString *_citypriceten;
    NSString *_citypriceeleven;
    NSString *_citypricetwelve;
    
    NSString *_education;
    NSString *_worktime;
    NSString *_unit;
    NSString *_unittype;
    NSNumber *_unitlook;
    NSString *_oneselfinfo;
    NSString *_teachertype;
    
    NSString *_head;
}

- (nonnull instancetype)initWithUserid:(NSString *)userid
                                 token:(NSString *)token
                              cardname:(NSString *)cardname
                                  nick:(NSString *)nick
                                   sex:(NSString *)sex
{
    self = [super init];
    if (self) {
        _userid = userid;
        _token = token;
        _nick = nick;
        _cardname = cardname;
        _sex = sex;
        self.validator = self;
    }
    
    return self;
}

- (nonnull instancetype)initWithUserid:(NSString *)userid
                                 token:(NSString *)token
                              cardname:(NSString *)cardname
                          citypriceone:(NSString *)citypriceone
                          citypricetwo:(NSString *)citypricetwo
                        citypricethree:(NSString *)citypricethree
                         citypricefour:(NSString *)citypricefour
                         citypricefive:(NSString *)citypricefive
                          citypricesix:(NSString *)citypricesix
                        citypriceseven:(NSString *)citypriceseven
                        citypriceeight:(NSString *)citypriceeight
                         citypricenine:(NSString *)citypricenine
                          citypriceten:(NSString *)citypriceten
                       citypriceeleven:(NSString *)citypriceeleven
                       citypricetwelve:(NSString *)citypricetwelve
{
    self = [super init];
    if (self) {
        _userid = userid;
        _token = token;
        _cardname = cardname;
        _citypriceone = citypriceone;
        _citypricetwo = citypricetwo;
        _citypricethree = citypricethree;
        _citypricefour = citypricefour;
        _citypricefive = citypricefive;
        _citypricesix = citypricesix;
        _citypriceseven = citypriceseven;
        _citypriceeight = citypriceeight;
        _citypricenine = citypricenine;
        _citypriceten = citypriceten;
        _citypriceeleven = citypriceeleven;
        _citypricetwelve = citypricetwelve;
        self.validator = self;
    }
    
    return self;
}

- (nonnull instancetype)initWithUserid:(NSString *)userid
                                 token:(NSString *)token
                              cardname:(NSString *)cardname
                                   sex:(NSString *)sex
                             education:(NSString *)education
                              worktime:(NSString *)worktime
                                  unit:(NSString *)unit
                              unittype:(NSString *)unittype
                              unitlook:(NSNumber *)unitlook
                           oneselfinfo:(NSString *)oneselfinfo
{
    self = [super init];
    if (self) {
        _userid = userid;
        _token = token;
        _cardname = cardname;
        _sex = sex;
        _education = education;
        _worktime = worktime;
        _unit = unit;
        _unittype = unittype;
        _unitlook = unitlook;
        _oneselfinfo = oneselfinfo;
        self.validator = self;
    }
    
    return self;
}

- (nonnull instancetype)initWithUserid:(NSString *)userid
                                 token:(NSString *)token
                              cardname:(NSString *)cardname
                           teachertype:(NSString *)teachertype
{
    self = [super init];
    if (self) {
        _userid = userid;
        _token = token;
        _cardname = cardname;
        _teachertype = teachertype;
        self.validator = self;
    }
    
    return self;
}

- (nonnull instancetype)initWithUserid:(NSString *)userid
                                 token:(NSString *)token
                              cardname:(NSString *)cardname
                                  head:(NSString *)head
{
    self = [super init];
    if (self) {
        _userid = userid;
        _token = token;
        _cardname = cardname;
        _head = head;
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
    return @"home/teacher/teacher_edit";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
    [dict setValue:_userid forKey:@"userid"];
    [dict setValue:_token forKey:@"token"];
    [dict setValue:_nick forKey:@"nick"];
    [dict setValue:_cardname forKey:@"cardname"];
    [dict setValue:_sex forKey:@"sex"];
    [dict setValue:_citypriceone forKey:@"citypriceone"];
    [dict setValue:_citypricetwo forKey:@"citypricetwo"];
    [dict setValue:_citypricethree forKey:@"citypricethree"];
    [dict setValue:_citypricefour forKey:@"citypricefour"];
    [dict setValue:_citypricefive forKey:@"citypricefive"];
    [dict setValue:_citypricesix forKey:@"citypricesix"];
    [dict setValue:_citypriceseven forKey:@"citypriceseven"];
    [dict setValue:_citypriceeight forKey:@"citypriceeight"];
    [dict setValue:_citypricenine forKey:@"citypricenine"];
    [dict setValue:_citypriceten forKey:@"citypriceten"];
    [dict setValue:_citypriceeleven forKey:@"citypriceeleven"];
    [dict setValue:_citypricetwelve forKey:@"citypricetwelve"];
    
    [dict setValue:_education forKey:@"education"];
    [dict setValue:_worktime forKey:@"worktime"];
    [dict setValue:_unit forKey:@"unit"];
    [dict setValue:_unittype forKey:@"unittype"];
    [dict setValue:_unitlook forKey:@"unitlook"];
    [dict setValue:_oneselfinfo forKey:@"oneselfinfo"];
    
    [dict setValue:_teachertype forKey:@"teachertype"];
    
    [dict setValue:_head forKey:@"head"];
    return dict;
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
