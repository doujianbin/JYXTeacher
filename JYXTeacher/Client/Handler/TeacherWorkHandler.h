//
//  TeacherWorkHandler.h
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/12.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "BaseHandler.h"

@interface TeacherWorkHandler : BaseHandler

//上传版本号
+ (void)postVersionSystemWithNum:(NSString *)num type:(NSString *)type prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)teacherAddReviewWithClassId:(NSString *)classId teachercomment:(NSString *)teachercomment teachercontent:(NSString *)teachercontent teacherlabel:(NSString *)teacherlabel prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

/*
 *举报人手机号 phone    被举报人手机号 targetphone    被举报人身份 targettype (1教师2学生)
 *  内容 content
 */
+ (void)teacherReportWithPhone:(NSString *)phone targetphone:(NSString *)targetphone targettype:(int)targettype content:(NSString *)content prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//教师缴纳罚款
+(void)teacherpayforWithPaytype:(NSString *)paytype money:(NSString *)money prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//教师查询钱包余额
+(void)teacherSelectWalletMoneyWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//教师上课列表
+ (void)teacherWorkListWithStartTime:(NSString *)startTime page:(int)page type:(int)type prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取虚拟电话
+ (void)selectXuNiPhoneNumWithPhone:(NSString *)phone otherphone:(NSString *)otherphone prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取虚拟电话号码
+ (void)selectXuNiPhoneNumWithUrl:(NSString *)url prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//提交课前，课后作业
+ (void)postWorkWithCourseId:(NSString *)courseId content:(NSString *)content type:(NSNumber *)type pic:(NSString *)pic prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
