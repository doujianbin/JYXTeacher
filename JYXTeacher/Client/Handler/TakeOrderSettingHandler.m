//
//  TakeOrderSettingHandler.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/11.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "TakeOrderSettingHandler.h"
#import "APIConfig.h"

@implementation TakeOrderSettingHandler

+ (void)getTeacherInfoWithUserid:(NSString *)userid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_logiNTeacherinfo];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    JYXUser *user = [JYXUserManager shareInstance].user;
    if (userid) {
        [dic setObject:userid forKey:@"userid"];
    }
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                      parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }
//                                              else{
//                                                  [MBProgressHUD hideHUD];
//                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
//                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+ (void)getTeacherLessonTimeWithUserid:(NSString *)userid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherLessonTime];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    JYXUser *user = [JYXUserManager shareInstance].user;
    if (userid) {
        [dic setObject:userid forKey:@"teacherid"];
    }
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                      parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+ (void)postTeacherLessonClassWithClassStr:(NSString *)classStr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherLessonClass];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    JYXUser *user = [JYXUserManager shareInstance].user;
    if (classStr) {
        [dic setObject:classStr forKey:@"onr"];
    }
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"teacherid"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                     parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+ (void)postTeacherLessonTimeWithTimeStr:(NSString *)timeStr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherLessonClass];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    JYXUser *user = [JYXUserManager shareInstance].user;
    if (timeStr) {
        [dic setObject:timeStr forKey:@"times"];
    }
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"teacherid"];
    }
    
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                 parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+ (void)postTeacherLessonRangeWithRangeStr:(NSString *)rangeStr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherLessonClass];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    JYXUser *user = [JYXUserManager shareInstance].user;
    if (rangeStr) {
        [dic setObject:rangeStr forKey:@"range"];
    }
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"teacherid"];
    }
    
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                   parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+ (void)postTeacherFangShiWithTeachertohome:(BOOL)teachertohome studenttohome:(BOOL)studenttohome addr:(NSString *)addr otheraddr:(BOOL)otheraddr shareaddr:(BOOL)shareaddr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherLessonClass];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    JYXUser *user = [JYXUserManager shareInstance].user;
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"teacherid"];
    }
    [dic setObject:[NSNumber numberWithBool:teachertohome] forKey:@"teachertohome"];
    [dic setObject:[NSNumber numberWithBool:studenttohome] forKey:@"studenttohome"];
    [dic setObject:[NSNumber numberWithBool:otheraddr] forKey:@"otheraddr"];
    [dic setObject:[NSNumber numberWithBool:shareaddr] forKey:@"shareaddr"];
    if (addr) {
        [dic setObject:addr forKey:@"addr"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                   parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

@end
