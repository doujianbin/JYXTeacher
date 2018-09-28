//
//  TeacherWorkHandler.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/12.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "TeacherWorkHandler.h"

@implementation TeacherWorkHandler

+ (void)teacherAddReviewWithClassId:(NSString *)classId teachercomment:(NSString *)teachercomment teachercontent:(NSString *)teachercontent teacherlabel:(NSString *)teacherlabel prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherAddReview];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    JYXUser *user = [JYXUserManager shareInstance].user;
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"teacherid"];
    }
    if (classId) {
        [dic setObject:classId forKey:@"id"];
    }
    if (teachercomment) {
        [dic setObject:teachercomment forKey:@"teachercomment"];
    }
    if (teachercontent) {
        [dic setObject:teachercontent forKey:@"teachercontent"];
    }
    if (teacherlabel) {
        [dic setObject:teacherlabel forKey:@"teacherlabel"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
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

+ (void)teacherReportWithPhone:(NSString *)phone targetphone:(NSString *)targetphone targettype:(int)targettype content:(NSString *)content prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherReport];
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"teacherid"];
    }
    if (phone) {
        [dic setObject:phone forKey:@"phone"];
    }
    if (targetphone) {
        [dic setObject:targetphone forKey:@"targetphone"];
    }
    if (targettype) {
        [dic setObject:[NSNumber numberWithInt:targettype] forKey:@"targettype"];
    }
    if (content) {
        [dic setObject:content forKey:@"content"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
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

//教师缴纳罚款
+(void)teacherpayforWithPaytype:(NSString *)paytype money:(NSString *)money prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_Teacherpayfor];
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"userid"];
    }
    if (paytype) {
        [dic setObject:paytype forKey:@"paytype"];
    }
    NSString *str1 = [money substringFromIndex:1];
    [dic setObject:str1 forKey:@"money"];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
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

//教师查询钱包余额
+(void)teacherSelectWalletMoneyWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherPurse];
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
                                              }else if ([[responseObject objectForKey:@"code"] intValue] == 1004){
                                                  [[JYXUserManager shareInstance].user clear];
                                                  [[JYXUserManager shareInstance] save];
                                                  JYXLoginViewController *login = [[JYXLoginViewController alloc] init];
                                                  [[JYXBaseViewController getCurrentVC] presentViewController:login animated:YES completion:nil];
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//教师上课列表
+ (void)teacherWorkListWithStartTime:(NSString *)startTime page:(int)page type:(int)type prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_TeacherWorkList];
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"teacherid"];
    }
    if (startTime) {
        [dic setObject:startTime forKey:@"startime"];
    }
//    [dic setObject:startTime forKey:@"startime"];
    [dic setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [dic setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [dic setObject:[NSNumber numberWithInt:10] forKey:@"limitnum"];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else if ([[responseObject objectForKey:@"code"] intValue] == 1004){
                                                  [[JYXUserManager shareInstance].user clear];
                                                  [[JYXUserManager shareInstance] save];
                                                  JYXLoginViewController *login = [[JYXLoginViewController alloc] init];
                                                  [[JYXBaseViewController getCurrentVC] presentViewController:login animated:YES completion:nil];
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//获取虚拟电话
+ (void)selectXuNiPhoneNumWithPhone:(NSString *)phone otherphone:(NSString *)otherphone prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Login,API_POST_SelectPhoneNum];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"phone"];
    [dic setObject:otherphone forKey:@"otherphone"];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else if ([[responseObject objectForKey:@"code"] intValue] == 1004){
                                                  [[JYXUserManager shareInstance].user clear];
                                                  [[JYXUserManager shareInstance] save];
                                                  JYXLoginViewController *login = [[JYXLoginViewController alloc] init];
                                                  [[JYXBaseViewController getCurrentVC] presentViewController:login animated:YES completion:nil];
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//获取虚拟电话号码
+ (void)selectXuNiPhoneNumWithUrl:(NSString *)url prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [[RTHttpClient defaultClient] requestWithPath:url
                                           method:RTHttpRequestGet                                parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else if ([[responseObject objectForKey:@"code"] intValue] == 1004){
                                                  [[JYXUserManager shareInstance].user clear];
                                                  [[JYXUserManager shareInstance] save];
                                                  JYXLoginViewController *login = [[JYXLoginViewController alloc] init];
                                                  [[JYXBaseViewController getCurrentVC] presentViewController:login animated:YES completion:nil];
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//提交课前，课后作业
+ (void)postWorkWithCourseId:(NSString *)courseId content:(NSString *)content type:(NSNumber *)type pic:(NSString *)pic prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (user.token) {
        [dic setObject:user.token forKey:@"token"];
    }
    if (user.userId) {
        [dic setObject:user.userId forKey:@"teacherid"];
    }
    [dic setValue:courseId forKey:@"id"];
    if (content) {
        [dic setObject:content forKey:@"content"];
    }
    [dic setObject:type forKey:@"type"];
    [dic setObject:pic forKey:@"pic"];
    NSString *str_url = [NSString stringWithFormat:@"%@/home/teacher/homework",API_Login];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet                                parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"code"] intValue] == 1000) {
                                                  success(responseObject[@"result"]);
                                              }else if ([[responseObject objectForKey:@"code"] intValue] == 1004){
                                                  [[JYXUserManager shareInstance].user clear];
                                                  [[JYXUserManager shareInstance] save];
                                                  JYXLoginViewController *login = [[JYXLoginViewController alloc] init];
                                                  [[JYXBaseViewController getCurrentVC] presentViewController:login animated:YES completion:nil];
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"msg"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

@end
