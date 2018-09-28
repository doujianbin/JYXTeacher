//
//  JYXHomeTeacherHomeworkApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherHomeworkApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>

/**
 发布作业（课前/课后）

 @param courseId 课程ID
 @param content 作业内容
 @param type 作业类型1.课前作业2.课后作业
 @param teacherid 教师ID
 @param token 用户token
 @param pic 课后作业图片
 @param prepic 课前作业图片
 @return JYXHomeTeacherHomeworkApi
 */
- (nonnull instancetype)initWithCourseId:(NSString *)courseId content:(NSString *)content type:(NSNumber *)type teacherid:(NSString *)teacherid token:(NSString *)token pic:(NSString *)pic prepic:(NSString *)prepic;

@end
