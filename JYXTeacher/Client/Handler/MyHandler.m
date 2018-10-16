//
//  MyHandler.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/13.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "MyHandler.h"

@implementation MyHandler

+ (void)getTeacherClassMoneyPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherClassMoney];
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"userid"];
    }
   
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showInfoMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+ (void)teacherPayNumWithUserType:(int)usertype weixin:(NSString *)weixin zhifubao:(NSString *)zhifubao yinlian:(NSString *)yinlian cardname:(NSString *)cardname prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeachePpaynumber];
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"userid"];
    }
    [dic setObject:[NSNumber numberWithInt:usertype] forKey:@"usertype"];
    if (weixin) {
        [dic setObject:weixin forKey:@"weixin"];
    }
    if (zhifubao) {
        [dic setObject:zhifubao forKey:@"zhifubao"];
    }
    if (yinlian) {
        [dic setObject:yinlian forKey:@"yinlian"];
    }
    if (cardname) {
        [dic setObject:cardname forKey:@"cardname"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showInfoMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+ (void)teacherCashTargettype:(int)targettype accounttype:(int)accounttype money:(NSString *)money account:(int)account prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherCash];
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"userid"];
    }
    [dic setObject:[NSNumber numberWithInt:targettype] forKey:@"targettype"];
    [dic setObject:[NSNumber numberWithInt:accounttype] forKey:@"accounttype"];
    [dic setObject:[NSNumber numberWithInt:account] forKey:@"account"];
    [dic setObject:money forKey:@"money"];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              success(responseObject);
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
    
}

//获取教师认证信息
+ (void)selectTeacherBaseInfoPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherEdit];
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (user.userId) {
        [dic setObject:user.userId forKey:@"userid"];
    }
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              success(responseObject);
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//教师上传资料（基本资料）
+ (void)postTeacherInfoWithCardname:(NSString *)cardname sex:(NSString *)sex education:(NSString *)education worktime:(NSInteger)worktime unit:(NSString *)unit unittype:(NSString *)unittype unitlook:(BOOL)unitlook oneselfinfo:(NSString *)oneselfinfo prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherEdit];
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (user.userId) {
        [dic setObject:user.userId forKey:@"userid"];
    }
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    [dic setObject:cardname forKey:@"cardname"];
    [dic setObject:sex forKey:@"sex"];
    [dic setObject:education forKey:@"education"];
    [dic setObject:[NSNumber numberWithInteger:worktime] forKey:@"worktime"];
    [dic setObject:unit forKey:@"unit"];
    [dic setObject:unittype forKey:@"unittype"];
    if (unitlook) {
        [dic setObject:[NSNumber numberWithInt:unitlook] forKey:@"unitlook"];
    }
    if (oneselfinfo) {
        [dic setObject:oneselfinfo forKey:@"oneselfinfo"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                                  JYXUser *user = [JYXUserManager shareInstance].user;
                                                  [user clear];
                                                  [user configUserData:responseObject[@"result"]];
                                                  
//                                                  [[JYXUserManager shareInstance] save];
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showInfoMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//获取融云通讯用户的头像和昵称
+ (void)selectRCIMInformationWithUserId:(NSString *)userid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@home/student/getheadname",API_Login];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userid forKey:@"id"];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//上传registionid
+ (void)pushJpushRegistionidWithRegistionid:(NSString *)registionid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_GetRegistration];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:registionid forKey:@"registratid"];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showInfoMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//获取问题反馈列表
+ (void)getFeedbackquestionPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_Feedbackquestion];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showInfoMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//提交用户反馈
+ (void)postUserQusetionWithPhone:(NSString *)phone question:(NSString *)question email:(NSString *)email content:(NSString *)content prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_Postfeedback];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"phone"];
    [dic setObject:question forKey:@"question"];
    [dic setObject:email forKey:@"email"];
    [dic setObject:content forKey:@"content"];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success([responseObject objectForKey:@"result"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showInfoMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//获取共享列表数据
+ (void)getShareListDataPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_Sharelist];
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (user.userId) {
        [dic setObject:user.userId forKey:@"userid"];
    }
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    [dic setObject:@"2" forKey:@"type"];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success([responseObject objectForKey:@"result"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showInfoMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+ (void)textjiekouWithStr:(NSMutableDictionary *)str prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = @"http://192.168.1.101:8080/home/login/sendsms";
    NSDictionary *parameters = @{
                                 @"phone":@"18641584903"
                                 };
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:nil];
    NSString * temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    NSMutableDictionary *dic_pra = [NSMutableDictionary dictionary];
    [dic_pra setValue:temp forKey:@"jsonParam"];
    
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                              parameters:dic_pra
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}



@end
