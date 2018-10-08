//
//  TakeOrderSettingHandler.h
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/11.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "BaseHandler.h"

@interface TakeOrderSettingHandler : BaseHandler

+ (void)getTeacherInfoWithUserid:(NSString *)userid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)getTeacherLessonTimeWithUserid:(NSString *)userid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)postTeacherLessonClassWithClassStr:(NSString *)classStr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)postTeacherLessonTimeWithTimeStr:(NSString *)timeStr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)postTeacherLessonRangeWithRangeStr:(NSString *)rangeStr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (void)postTeacherFangShiWithTeachertohome:(BOOL)teachertohome studenttohome:(BOOL)studenttohome addr:(NSString *)addr otheraddr:(BOOL)otheraddr shareaddr:(BOOL)shareaddr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
