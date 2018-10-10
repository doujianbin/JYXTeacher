//
//  MyHandler.h
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/13.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "BaseHandler.h"

@interface MyHandler : BaseHandler

+ (void)getTeacherClassMoneyPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)teacherPayNumWithUserType:(int)usertype weixin:(NSString *)weixin zhifubao:(NSString *)zhifubao yinlian:(NSString *)yinlian cardname:(NSString *)cardname prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)teacherCashTargettype:(int)targettype accounttype:(int)accounttype money:(NSString *)money account:(int)account prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)selectTeacherBaseInfoPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//教师上传资料
+ (void)postTeacherInfoWithCardname:(NSString *)cardname sex:(NSString *)sex education:(NSString *)education worktime:(NSInteger)worktime unit:(NSString *)unit unittype:(NSString *)unittype unitlook:(BOOL)unitlook oneselfinfo:(NSString *)oneselfinfo prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取融云通讯用户的头像和昵称
+ (void)selectRCIMInformationWithUserId:(NSString *)userid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//上传registionid
+ (void)pushJpushRegistionidWithRegistionid:(NSString *)registionid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取问题反馈列表
+ (void)getFeedbackquestionPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//提交用户反馈
+ (void)postUserQusetionWithPhone:(NSString *)phone question:(NSString *)question email:(NSString *)email content:(NSString *)content prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取共享列表数据
+ (void)getShareListDataPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
