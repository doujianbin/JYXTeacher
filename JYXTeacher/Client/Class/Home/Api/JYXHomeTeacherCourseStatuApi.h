//
//  JYXHomeTeacherCourseStatuApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherCourseStatuApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 课程完成
 
 @param teacherid 用户ID
 @param token 用户token
 @param courseId 课程ID
 @param type 课程状态
 @return JYXHomeTeacherSearchInfoApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)teacherid WithToken:(nonnull NSString *)token courseId:(NSString *)courseId type:(NSString *)type;

@end
